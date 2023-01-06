import 'package:flutter/material.dart';
import 'package:geeruh/api/api_build.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:geeruh/main.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'board_store.g.dart';

class BoardStore extends _BoardStore with _$BoardStore {}

abstract class _BoardStore with Store {
  late ApiRequests _api;
  var projectCode = "";
  Future<void> init(BuildContext context) async {
    _api = Provider.of<ApiRequests>(context);

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    projectCode = arguments['projectCode'];

    await getStatuses(context);
    await getIssues(navigatorKey.currentContext!);
    await getUsers(navigatorKey.currentContext!);
  }

  @observable
  ObservableList<IssueRes> issues = ObservableList.of([]);

  @observable
  ObservableList<StatusRes> statuses = ObservableList.of([]);

  @observable
  ObservableList<UserRes> users = ObservableList.of([]);

  @observable
  ObservableFuture futureGetIssues = ObservableFuture.value(null);

  @observable
  String assignee = "";

  @action
  void setAssignee(String newAssignee) {
    assignee = newAssignee;
  }

  @action
  Future getIssues(BuildContext context) {
    return futureGetIssues = ObservableFuture(_getIssues(context));
  }

  Future _getIssues(BuildContext context) async {
    final response = await apiRequest(_api.getIssues(), context);
    if (response.isSuccessful) {
      issues.clear();
      for (var issue in ObservableList.of(response.body!)) {
        var issueId = issue.issueId.split("-")[0];
        if (issueId == projectCode) {
          issues.add(issue);
        }
      }
    }
  }

  @observable
  ObservableFuture futureGetStatuses = ObservableFuture.value(null);

  @action
  Future getStatuses(BuildContext context) {
    return futureGetStatuses = ObservableFuture(_getStatuses(context));
  }

  Future _getStatuses(BuildContext context) async {
    statuses.clear();
    final response = await apiRequest(_api.getStatuses(), context);
    if (response.isSuccessful) {
      statuses.sort(((a, b) => a.orderNumber.compareTo(b.orderNumber)));
      for (var status in ObservableList.of(response.body!)) {
        if (status.code.startsWith(projectCode)) {
          statuses.add(status);
        }
      }
    }
  }

  @observable
  ObservableFuture futureGetUsers = ObservableFuture.value(null);

  @action
  Future getUsers(BuildContext context) {
    return futureGetUsers = ObservableFuture(_getUsers(context));
  }

  Future _getUsers(BuildContext context) async {
    final response = await apiRequest(_api.getUsers(), context);
    if (response.isSuccessful) {
      users = ObservableList.of(response.body!);
    }
  }

  UserRes getUserById(String userId) {
    return users.firstWhere((user) => user.userId == userId);
  }

  String getUserNameAndSurname(String userId) {
    UserRes user = getUserById(userId);
    return "${user.firstName} ${user.surname}";
  }

  List<String> getUsersNamesWithEmptyOne() {
    List<String> usersNames =
        users.map((user) => getUserNameAndSurname(user.userId)).toList();
    usersNames.add("Empty");
    return usersNames;
  }

  List<String> getIssueIdsWithEmptyOne() {
    List<String> issuesIds = issues.map((issue) => issue.issueId).toList();
    issuesIds.add("Empty");
    return issuesIds;
  }

  List<String> getIssuesWithoutSelectedOnes(IssueRes currentIssue) {
    List<String> issuesIds = issues.map((issue) => issue.issueId).toList();
    issuesIds.removeWhere((issueId) =>
        currentIssue.issueId == issueId ||
        currentIssue.relatedIssues.contains(issueId) ||
        currentIssue.relatedIssuesChildren.contains(issueId));
    issuesIds.add("Empty");
    return issuesIds;
  }

  String getUserIdByName(String userName) {
    if (userName == "Empty") {
      return "";
    } else {
      List<String> userNewName = userName.split(" ");
      return users
          .firstWhere((user) =>
              user.firstName == userNewName[0] &&
              user.surname == userNewName[1])
          .userId;
    }
  }

  IssueRes getIssueById(String issueId) {
    return issues.firstWhere((issue) => issue.issueId == issueId);
  }

  @observable
  ObservableFuture futureUpdateIssueStatus = ObservableFuture.value(null);

  @action
  Future updateIssueStatus(
      BuildContext context, String issueId, String newStatusCode) {
    return futureUpdateIssueStatus =
        ObservableFuture(_updateIssueStatus(context, issueId, newStatusCode));
  }

  Future _updateIssueStatus(
      BuildContext context, String issueId, String newStatusCode) async {
    await apiRequest(
        _api.updateIssueStatus(
          issueId,
          ChangeIssueStatusReq(statusCode: newStatusCode),
        ),
        context);
  }
}

import 'package:flutter/material.dart';
import 'package:geeruh/api/api_build.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:geeruh/main.dart';
import 'package:geeruh/screens/board/board_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'gee_task_editor_store.g.dart';

class GeeTaskEditorStore extends _GeeTaskEditorStore with _$GeeTaskEditorStore {
}

abstract class _GeeTaskEditorStore with Store {
  late ApiRequests _api;

  Future<void> init(
      BuildContext context, IssueRes issue, BoardStore boardStore) async {
    _api = Provider.of<ApiRequests>(context);
    type = issue.type;
    summary = issue.summary;
    description = issue.description;
    boardStoreToGet = boardStore;
    if (issue.issueId.isNotEmpty) {
      await getIssueHistory(context, issue.issueId);
    }
  }

  @observable
  String? summary;

  @observable
  String? description;

  @observable
  String? type;

  BoardStore? boardStoreToGet;

  ObservableList<IssueHistoryRes>? issueHistory;

  @observable
  String selectedParentIssue = "";

  @action
  selectParentIssue(String newParentIssue) {
    selectedParentIssue = newParentIssue;
  }

  @observable
  String selectedChildIssue = "";

  @action
  selectChildIssue(String newChildIssue) {
    selectedChildIssue = newChildIssue;
  }

  @observable
  ObservableFuture futureGetIssueHistory = ObservableFuture.value(null);

  @action
  Future getIssueHistory(BuildContext context, String issueId) {
    return futureGetIssueHistory =
        ObservableFuture(_getIssueHistory(context, issueId));
  }

  Future _getIssueHistory(BuildContext context, String issueId) async {
    final response = await apiRequest(_api.getIssueHistory(issueId), context);
    if (response.isSuccessful) {
      issueHistory = ObservableList.of(response.body!);
    }
  }

  @observable
  ObservableFuture futureUpdateIssue = ObservableFuture.value(null);

  @action
  Future updateIssue(
      BuildContext context, String issueId, String? newAssignee) {
    return futureUpdateIssue =
        ObservableFuture(_updateIssue(context, issueId, newAssignee));
  }

  Future _updateIssue(
      BuildContext context, String issueId, String? newAssignee) async {
    final responseUpdateAssignee = await apiRequest(
        _api.updateIssueAssignee(
            issueId, UpdateIssueAssigneeReq(assigneeUserId: newAssignee ?? "")),
        context);

    if (responseUpdateAssignee.isSuccessful) {
      final response = await apiRequest(
          _api.updateIssue(
              issueId,
              PutIssueReq(
                  type: type!, summary: summary, description: description)),
          navigatorKey.currentContext!);
      if (response.isSuccessful) {
        Navigator.pop(navigatorKey.currentContext!);
        await boardStoreToGet!.getIssues(navigatorKey.currentContext!);
      }
    }
  }

  @observable
  ObservableFuture futureMakeIssueRelation = ObservableFuture.value(null);

  @action
  Future makeIssueRelation(
      BuildContext context, String issueId, String relatedIssueId) {
    return futureMakeIssueRelation =
        ObservableFuture(_makeIssueRelation(context, issueId, relatedIssueId));
  }

  Future _makeIssueRelation(
      BuildContext context, String issueId, String relatedIssueId) async {
    final response = await apiRequest(
        _api.makeIssueRelation(issueId, relatedIssueId), context);
    if (response.isSuccessful) {
      await boardStoreToGet!.getIssues(navigatorKey.currentContext!);
    }
  }

  @action
  Future removeIssueRelation(
      BuildContext context, String issueId, String relatedIssueId) {
    return futureMakeIssueRelation = ObservableFuture(
        _removeIssueRelation(context, issueId, relatedIssueId));
  }

  Future _removeIssueRelation(
      BuildContext context, String issueId, String relatedIssueId) async {
    final response = await apiRequest(
        _api.removeIssueRelation(issueId, relatedIssueId), context);
    if (response.isSuccessful) {
      await boardStoreToGet!.getIssues(navigatorKey.currentContext!);
    }
  }

  @observable
  ObservableFuture futurePostIssue = ObservableFuture.value(null);

  @action
  Future postIssue(BuildContext context) {
    return futurePostIssue = ObservableFuture(_postIssue(context));
  }

  Future _postIssue(BuildContext context) async {
    final response = await apiRequest(
        _api.postIssue(
            PutIssueReq(
                type: type!, summary: summary, description: description),
            boardStoreToGet!.projectCode,
            boardStoreToGet!.statuses.first.code),
        context);
    if (response.isSuccessful) {
      Navigator.pop(navigatorKey.currentContext!);
      await boardStoreToGet!.getIssues(navigatorKey.currentContext!);
    }
  }
}

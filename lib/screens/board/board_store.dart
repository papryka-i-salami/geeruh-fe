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

  Future<void> init(BuildContext context) async {
    _api = Provider.of<ApiRequests>(context);
    await getStatuses(navigatorKey.currentContext!);
    await getIssues(navigatorKey.currentContext!);
  }

  @observable
  ObservableList<IssueRes> issues = ObservableList.of([]);

  @observable
  ObservableList<StatusRes> statuses = ObservableList.of([]);

  @observable
  ObservableFuture futureGetIssues = ObservableFuture.value(null);

  @action
  Future getIssues(BuildContext context) {
    return futureGetIssues = ObservableFuture(_getIssues(context));
  }

  Future _getIssues(BuildContext context) async {
    final response = await apiRequest(_api.getIssues(), context);
    if (response.isSuccessful) {
      issues = ObservableList.of(response.body!);
    }
  }

  @observable
  ObservableFuture futureGetStatuses = ObservableFuture.value(null);

  @action
  Future getStatuses(BuildContext context) {
    return futureGetStatuses = ObservableFuture(_getStatuses(context));
  }

  Future _getStatuses(BuildContext context) async {
    final response = await apiRequest(_api.getStatuses(), context);
    if (response.isSuccessful) {
      statuses = ObservableList.of(response.body!);
      statuses.sort(((a, b) => a.orderNumber.compareTo(b.orderNumber)));
    }
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
    final response = await apiRequest(
        _api.updateIssueStatus(
          issueId,
          ChangeIssueStatusReq(statusCode: newStatusCode),
        ),
        context);
    if (response.isSuccessful) {
      print("successful");
    }
  }
}

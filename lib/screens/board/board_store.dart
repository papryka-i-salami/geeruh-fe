import 'package:flutter/material.dart';
import 'package:geeruh/api/api_build.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:geeruh/api/api_requests.dart';
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

    await getIssues(context);
  }

  @observable
  ObservableFuture futureGetIssues = ObservableFuture.value(null);

  @observable
  ObservableList<IssueRes> issues = ObservableList.of([]);

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
}

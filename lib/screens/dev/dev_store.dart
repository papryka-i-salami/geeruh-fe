import 'package:flutter/material.dart';
import 'package:geeruh/api/api_build.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:geeruh/main.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'dev_store.g.dart';

class DevStore extends _DevStore with _$DevStore {}

abstract class _DevStore with Store {
  late ApiRequests _api;

  ObservableList<IssueRes> issues = ObservableList.of([]);

  @observable
  String greeting = "";

  Future<void> init(BuildContext context) async {
    _api = Provider.of<ApiRequests>(context);
  }

  @observable
  ObservableFuture futureHelloWorld = ObservableFuture.value(null);

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
      _showSnackBar("Pobrano issues");
    }
  }
}

_showSnackBar(String text) {
  SnackBar snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
}

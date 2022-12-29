import 'package:flutter/material.dart';
import 'package:geeruh/api/api_build.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:geeruh/main.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:geeruh/widgets/list_button.dart';

part 'start_store.g.dart';

class StartStore extends _StartStore with _$StartStore {}

abstract class _StartStore with Store {
  late ApiRequests _api;

  ObservableList<IssueRes> issues = ObservableList.of([]);
  ObservableList<ProjectRes> projects = ObservableList.of([]);

  @observable
  String greeting = "";

  Future<void> init(BuildContext context) async {
    _api = Provider.of<ApiRequests>(context);

    await getProjects(context);
  }

  @observable
  ObservableFuture futureHelloWorld = ObservableFuture.value(null);

  @observable
  ObservableFuture futureGetIssues = ObservableFuture.value(null);

  @observable
  ObservableFuture futureGetProjects = ObservableFuture.value(null);

  @observable
  List<Widget> entries = [
    listButton(() {}, "aaa"),
    const Text('Entry 2'),
    const Text('Entry 32')
  ];

  @action
  Future getIssues(BuildContext context) {
    return futureGetIssues = ObservableFuture(_getIssues(context));
  }

  Future _getIssues(BuildContext context) async {
    final response = await apiRequest(_api.getIssues(), context);
    if (response.isSuccessful) {
      issues = ObservableList.of(response.body!);
      _showSnackBar(navigatorKey.currentContext!, "Pobrano issues");
    }
  }

  @action
  Future getProjects(BuildContext context) {
    return futureGetProjects = ObservableFuture(_getProjects(context));
  }

  Future _getProjects(BuildContext context) async {
    final response = await apiRequest(_api.getProjects(), context);
    if (response.isSuccessful) {
      projects = ObservableList.of(response.body!);
      _showSnackBar(navigatorKey.currentContext!, "Pobrano projects");
      entries =
          projects.map((project) => listButton(() {}, project.name)).toList();
    }
  }
}

_showSnackBar(BuildContext context, String text) {
  SnackBar snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

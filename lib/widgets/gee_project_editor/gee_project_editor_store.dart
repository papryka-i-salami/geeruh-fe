import 'package:flutter/material.dart';
import 'package:geeruh/api/api_build.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:geeruh/main.dart';
import 'package:geeruh/screens/start/start_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'gee_project_editor_store.g.dart';

class GeeProjectEditorStore extends _GeeProjectEditorStore
    with _$GeeProjectEditorStore {}

abstract class _GeeProjectEditorStore with Store {
  late ApiRequests _api;

  Future<void> init(
      BuildContext context, StartStore startStore, ProjectRes? project) async {
    _api = Provider.of<ApiRequests>(context);
    code = project?.code;
    name = project?.name;
    description = project?.description;
    startStoreToGet = startStore;
    await getStatuses(context);
  }

  @observable
  String? code;

  @observable
  String? name;

  @observable
  String? description;

  @observable
  String? statusName;

  @observable
  String? statusCode;

  @observable
  int? orderNumber;

  StartStore? startStoreToGet;

  @observable
  ObservableFuture futureUpdateProject = ObservableFuture.value(null);

  @observable
  ObservableFuture futurePostProject = ObservableFuture.value(null);

  @observable
  ObservableList<StatusRes> statuses = ObservableList.of([]);

  @observable
  ObservableFuture futureGetStatuses = ObservableFuture.value(null);

  @observable
  ObservableFuture futurePostStatuses = ObservableFuture.value(null);

  @action
  Future getStatuses(BuildContext context) {
    return futureGetStatuses = ObservableFuture(_getStatuses(context));
  }

  Future _getStatuses(BuildContext context) async {
    statuses.clear();
    final response = await apiRequest(_api.getStatuses(), context);
    if (response.isSuccessful) {
      orderNumber = response.body!.length + 1;
      if (code != null) {
        for (var status in ObservableList.of(response.body!)) {
          if (status.code.startsWith(code!)) {
            statuses.add(status);
          }
        }
      }
    }
  }

  @action
  Future postStatus(BuildContext context) {
    return futurePostProject = ObservableFuture(_postStatus(context));
  }

  Future _postStatus(BuildContext context) async {
    var newStatusCode = "$code$statusCode";
    final response = await apiRequest(
        _api.postStatus(newStatusCode,
            PostStatusReq(name: statusName!, orderNumber: orderNumber!)),
        context);
    if (response.isSuccessful) {
      await getStatuses(navigatorKey.currentContext!);
    }
  }

  @action
  Future updateProject(BuildContext context) {
    return futureUpdateProject = ObservableFuture(_updateProject(context));
  }

  Future _updateProject(BuildContext context) async {
    final response = await apiRequest(
        _api.putProject(code!,
            PutProjectReq(code: code!, name: name!, description: description)),
        context);
    if (response.isSuccessful) {
      Navigator.pop(navigatorKey.currentContext!);
      await startStoreToGet!.getProjects(navigatorKey.currentContext!);
    }
  }

  @action
  Future postProject(BuildContext context) {
    return futurePostProject = ObservableFuture(_postProject(context));
  }

  Future _postProject(BuildContext context) async {
    statusName = "Open";
    statusCode = "OPE";
    await postStatus(context);
    statusName = "In Progress";
    statusCode = "INP";
    await postStatus(navigatorKey.currentContext!);
    statusName = "Closed";
    statusCode = "CLO";
    await postStatus(navigatorKey.currentContext!);
    final response = await apiRequest(
        _api.postProject(
            code!, PostProjectReq(name: name!, description: description)),
        navigatorKey.currentContext!);
    if (response.isSuccessful) {
      Navigator.pop(navigatorKey.currentContext!);
      await startStoreToGet!.getProjects(navigatorKey.currentContext!);
    }
  }
}

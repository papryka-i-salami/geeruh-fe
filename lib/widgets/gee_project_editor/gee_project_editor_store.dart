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
  }

  @observable
  String? code;

  @observable
  String? name;

  @observable
  String? description;

  StartStore? startStoreToGet;

  @observable
  ObservableFuture futureUpdateProject = ObservableFuture.value(null);

  @observable
  ObservableFuture futurePostProject = ObservableFuture.value(null);

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
    final response = await apiRequest(
        _api.postProject(
            code!, PostProjectReq(name: name!, description: description)),
        context);
    if (response.isSuccessful) {
      Navigator.pop(navigatorKey.currentContext!);
      await startStoreToGet!.getProjects(navigatorKey.currentContext!);
    }
  }
}

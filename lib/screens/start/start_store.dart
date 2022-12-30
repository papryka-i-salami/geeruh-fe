import 'package:flutter/material.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:geeruh/api/api_build.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:geeruh/api/api_classes.dart';

part 'start_store.g.dart';

class StartStore extends _StartStore with _$StartStore {}

abstract class _StartStore with Store {
  late ApiRequests _api;

  Future<void> init(BuildContext context) async {
    _api = Provider.of<ApiRequests>(context);

    await getProjects(context);
  }

  @observable
  ObservableFuture futureGetProjects = ObservableFuture.value(null);

  @observable
  ObservableList<ProjectRes> projects = ObservableList.of([]);

  @action
  Future getProjects(BuildContext context) {
    return futureGetProjects = ObservableFuture(_getProjects(context));
  }

  Future _getProjects(BuildContext context) async {
    final response = await apiRequest(_api.getProjects(), context);
    if (response.isSuccessful) {
      projects = ObservableList.of(response.body!);
    }
  }
}

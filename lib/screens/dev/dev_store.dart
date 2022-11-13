import 'package:flutter/material.dart';
import 'package:geeruh/api/api_build.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'dev_store.g.dart';

// ignore: library_private_types_in_public_api
class DevStore = _DevStore with _$DevStore;

abstract class _DevStore with Store {
  late ApiRequests _api;

  @observable
  String greeting = "";

  Future<void> init(BuildContext context) async {
    _api = Provider.of<ApiRequests>(context);
  }

  @observable
  ObservableFuture futureHelloWorld = ObservableFuture.value(null);

  @action
  Future getHelloWorld(BuildContext context) {
    return futureHelloWorld = ObservableFuture(_getHelloWorld(context));
  }

  Future _getHelloWorld(BuildContext context) async {
    final response = await apiRequest(_api.getHelloWorld(), context);
    if (response.isSuccessful) {
      greeting = response.body!;
    }
  }
}
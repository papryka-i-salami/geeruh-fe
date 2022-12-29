import 'package:flutter/material.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:mobx/mobx.dart';

part 'dev_store.g.dart';

class DevStore extends _DevStore with _$DevStore {}

abstract class _DevStore with Store {
  ObservableList<IssueRes> issues = ObservableList.of([]);

  @observable
  String greeting = "";

  Future<void> init(BuildContext context) async {}
}

import 'package:flutter/material.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'gee_task_editor_store.g.dart';

class GeeTaskEditorStore extends _GeeTaskEditorStore with _$GeeTaskEditorStore {
}

abstract class _GeeTaskEditorStore with Store {
  // ignore: unused_field
  late ApiRequests _api;

  Future<void> init(BuildContext context) async {
    _api = Provider.of<ApiRequests>(context);
  }
}

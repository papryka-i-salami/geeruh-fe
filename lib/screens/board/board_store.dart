import 'package:flutter/material.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'board_store.g.dart';

// ignore: library_private_types_in_public_api
class BoardStore = _BoardStore with _$BoardStore;

abstract class _BoardStore with Store {
  late ApiRequests _api;

  Future<void> init(BuildContext context) async {
    _api = Provider.of<ApiRequests>(context);
  }
}

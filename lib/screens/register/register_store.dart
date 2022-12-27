import 'package:flutter/material.dart';
import 'package:geeruh/api/api_build.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:geeruh/global_constants.dart';
import 'package:geeruh/main.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'register_store.g.dart';

class RegisterStore extends _RegisterStore with _$RegisterStore {}

abstract class _RegisterStore with Store {
  late ApiRequests _api;

  Future<void> init(BuildContext context) async {
    _api = Provider.of<ApiRequests>(context);
  }

  @observable
  String login = "";
  @observable
  String password = "";
  @observable
  String email = "";
  @observable
  String firstName = "";
  @observable
  String secondName = "";
  @observable
  String surname = "";

  @observable
  ObservableFuture futureRegister = ObservableFuture.value(null);

  @action
  Future register(BuildContext context) {
    return futureRegister = ObservableFuture(_register(context));
  }

  Future _register(BuildContext context) async {
    final response = await apiRequest(
        _api.register(RegisterReq(
            login: login,
            password: password,
            email: email,
            firstName: firstName,
            secondName: secondName,
            surname: surname)),
        context);
    if (response.isSuccessful) {
      Navigator.pushNamed(
          navigatorKey.currentContext!, ConstantScreens.loginScreen);
    }
  }

  @observable
  ObservableFuture futureLogout = ObservableFuture.value(null);
}

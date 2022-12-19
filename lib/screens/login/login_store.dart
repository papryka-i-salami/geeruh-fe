import 'package:flutter/material.dart';
import 'package:geeruh/api/api_build.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:geeruh/cookies/cookie_store.dart';
import 'package:geeruh/global_constants.dart';
import 'package:geeruh/main.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'login_store.g.dart';

class LoginStore extends _LoginStore with _$LoginStore {}

abstract class _LoginStore with Store {
  late ApiRequests _api;
  late CookieStore _cookieStore;

  Future<void> init(BuildContext context) async {
    _api = Provider.of<ApiRequests>(context);
    _cookieStore = Provider.of<CookieStore>(context);
  }

  @observable
  ObservableFuture futureLogin = ObservableFuture.value(null);

  @observable
  String username = "";
  @observable
  String password = "";

  @action
  Future login(BuildContext context) {
    return futureLogin = ObservableFuture(_login(context));
  }

  Future _login(BuildContext context) async {
    final response = await apiRequest(
        _api.login(LoginReq(username: username, password: password)), context);
    if (response.isSuccessful) {
      Map<String, String> loginResponse = response.headers;
      String sessionId = loginResponse["set-cookie"] == null
          ? _cookieStore.cookieValue
          : loginResponse["set-cookie"]!.split(';')[0];

      _cookieStore.setCookieValue(sessionId);
      Navigator.pushNamed(
          navigatorKey.currentContext!, ConstantScreens.startScreen);
    }
  }

  @observable
  ObservableFuture futureLogout = ObservableFuture.value(null);

  @action
  Future logout(BuildContext context) {
    return futureLogout = ObservableFuture(_logout(context));
  }

  Future _logout(BuildContext context) async {
    final response = await apiRequest(_api.logout(), context);
    if (response.isSuccessful) {}
  }
}

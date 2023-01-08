import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geeruh/api/api_build.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:geeruh/cookies/cookie_store.dart';
import 'package:geeruh/gee_user_info.dart';
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
  String login = "";
  @observable
  String password = "";

  @action
  Future loginRequest(BuildContext context) {
    return futureLogin = ObservableFuture(_login(context));
  }

  Future _login(BuildContext context) async {
    final response = await apiRequest(
        _api.login(LoginReq(username: login, password: password)), context);
    if (response.isSuccessful) {
      if (!kIsWeb) {
        Map<String, String> loginResponse = response.headers;
        String sessionId = loginResponse["set-cookie"] == null
            ? _cookieStore.cookieValue
            : loginResponse["set-cookie"]!.split(';')[0];

        login = "";
        password = "";

        _cookieStore.setCookieValue(sessionId);
        // ignore: use_build_context_synchronously
        final sessionResponse = await apiRequest(_api.getSession(), context);
        if (sessionResponse.isSuccessful) {
          UserRes user = sessionResponse.body!;
          UserInfo.userName = user.firstName;
          UserInfo.userId = int.parse(
              "1${user.userId.replaceAll(RegExp('[^0-9]'), '')}".substring(6));
        }
      }
      Future.delayed(const Duration(milliseconds: 500));
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

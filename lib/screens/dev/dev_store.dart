import 'package:flutter/material.dart';
import 'package:geeruh/api/api_build.dart';
import 'package:geeruh/api/api_classes.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:geeruh/cookies/cookie_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'dev_store.g.dart';

// ignore: library_private_types_in_public_api
class DevStore = _DevStore with _$DevStore;

abstract class _DevStore with Store {
  late ApiRequests _api;
  late CookieStore _cookieStore;

  ObservableList<IssueRes> issues = ObservableList.of([]);

  @observable
  String greeting = "";

  Future<void> init(BuildContext context) async {
    _api = Provider.of<ApiRequests>(context);
    _cookieStore = Provider.of<CookieStore>(context);
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

  @observable
  ObservableFuture futureLogin = ObservableFuture.value(null);

  @action
  Future login(BuildContext context) {
    return futureLogin = ObservableFuture(_login(context));
  }

  Future _login(BuildContext context) async {
    final response =
        await _api.login(LoginReq(username: "user", password: "password"));
    if (response.isSuccessful) {
      Map<String, String> loginResponse = response.headers;
      String sessionId = loginResponse["set-cookie"] == null
          ? _cookieStore.cookieValue
          : loginResponse["set-cookie"]!.split(';')[0];

      _cookieStore.setCookieValue(sessionId);
      _showSnackBar(context, "Zalogowano");
    }
  }

  @observable
  ObservableFuture futureLogout = ObservableFuture.value(null);

  @action
  Future logout(BuildContext context) {
    return futureLogout = ObservableFuture(_logout(context));
  }

  Future _logout(BuildContext context) async {
    final response = await _api.logout();
    if (response.isSuccessful) {
      _showSnackBar(context, "Wylogowano");
    }
  }

  @observable
  ObservableFuture futureGetIssues = ObservableFuture.value(null);

  @action
  Future getIssues(BuildContext context) {
    return futureGetIssues = ObservableFuture(_getIssues(context));
  }

  Future _getIssues(BuildContext context) async {
    final response = await apiRequest(_api.getIssues(), context);
    if (response.isSuccessful) {
      issues = ObservableList.of(response.body!);
      _showSnackBar(context, "Pobrano issues");
    }
  }
}

_showSnackBar(BuildContext context, String text) {
  SnackBar snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

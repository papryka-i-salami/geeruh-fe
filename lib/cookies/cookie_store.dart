import 'package:geeruh/cookies/cookie_service.dart';
import 'package:mobx/mobx.dart';

part 'cookie_store.g.dart';

class CookieStore = _CookieStore with _$CookieStore;

abstract class _CookieStore with Store {
  final CookieService _cookieService;

  _CookieStore(this._cookieService) {
    _initCookieValue();
  }

  String _cookieValue = "";

  String get cookieValue => _cookieValue;

  void setCookieValue(String newCookieValue) {
    _cookieService.cookieValue = newCookieValue;
    _cookieValue = newCookieValue;
  }

  @action
  void _initCookieValue() {
    _cookieValue = _cookieService.cookieValue ?? "";
  }

  @action
  clearCookieValue() {
    _cookieService.cookieValue = "";
    _cookieValue = "";
  }
}

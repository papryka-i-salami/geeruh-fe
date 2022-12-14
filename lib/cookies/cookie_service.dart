import 'package:shared_preferences/shared_preferences.dart';

class ConstCookieValue {
  static const cookieValue = "cookieValue";
}

class CookieService {
  final SharedPreferences _preferences;
  CookieService(this._preferences);

  _getString(String field) {
    return _preferences.getString(field);
  }

  _setString(String field, String? value) {
    if (value != null) {
      _preferences.setString(field, value);
    } else {
      _preferences.remove(field);
    }
  }

  String? get cookieValue => _getString(ConstCookieValue.cookieValue);
  set cookieValue(String? value) =>
      _setString(ConstCookieValue.cookieValue, value);
}

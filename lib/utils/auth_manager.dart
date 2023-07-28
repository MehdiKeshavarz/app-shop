import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/di/locator.dart';

class AuthManager {
  static final ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);
  static final SharedPreferences _sharedPref = locator.get();

  static void saveToken(String token) async {
    _sharedPref.setString("access_token", token);
    authChangeNotifier.value = token;
  }

  static String readAuth() {
    return _sharedPref.getString("access_token") ?? '';
  }

  static void logOut() {
    _sharedPref.clear();
    authChangeNotifier.value = null;
  }
}

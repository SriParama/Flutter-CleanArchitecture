import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobleProvider with ChangeNotifier {
  String cookies = '';
  String cookieTime = '';
  getCookie() async {
    SharedPreferences sref = await SharedPreferences.getInstance();
    cookies = sref.getString("cookies") ?? "";
    cookieTime = sref.getString("cookieTime") ?? "";
    notifyListeners();
  }

  setCookies(String rawCookie, String newCookieTime) async {
    SharedPreferences sref = await SharedPreferences.getInstance();

    sref.setString("cookieTime", newCookieTime);
    sref.setString("cookies", rawCookie);
    cookies = rawCookie;
    cookieTime = newCookieTime;

    notifyListeners();
  }
}

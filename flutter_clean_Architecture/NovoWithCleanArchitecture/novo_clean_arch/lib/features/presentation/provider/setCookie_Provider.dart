import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationProvider with ChangeNotifier {
  String cookies = '';
  String cookieTime = ''; // Default to system mode

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

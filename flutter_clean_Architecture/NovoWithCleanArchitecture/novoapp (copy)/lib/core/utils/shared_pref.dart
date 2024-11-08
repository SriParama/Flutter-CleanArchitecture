import 'package:flutter/material.dart';
import 'package:novoapp/core/utils/end_point_address.dart';
import 'package:novoapp/core/utils/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SharedPrefRepository {
  Future<void> updateCookie(http.Response response) async {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null && rawCookie.isNotEmpty) {
      DateTime validateTime =
          // DateTime.now().add(Duration(seconds: 30));
          DateTime.now().add(Duration(
              seconds: int.parse(
                  rawCookie.split(";").toList()[3].split("=").toList()[1])));

      SharedPreferences sref = await SharedPreferences.getInstance();
      await sref.setString("cookieTime", validateTime.toString());
      await sref.setString("cookies", rawCookie);
    }
    // return "";
  }

  Future<String> getCookie() async {
    SharedPreferences sref = await SharedPreferences.getInstance();
    String cookies = sref.getString("cookies") ?? "";
    String cookieTime = sref.getString("cookieTime") ?? "";
    return cookies;
  }

  Future<bool> verifyCookies() async {
    SharedPreferences sref = await SharedPreferences.getInstance();
    String cookies = sref.getString("cookies") ?? "";
    String cookieTime = sref.getString("cookieTime") ?? "";
    if (cookieTime.isEmpty ||
        cookies.isEmpty ||
        DateTime.parse(cookieTime).difference(DateTime.now()).inMicroseconds <
            0) {
      ////print('false');
      return false;
    } else {
      ////print('true');
      return true;
    }
  }

  Future<void> deleteCookieInSref() async {
    SharedPreferences sref = await SharedPreferences.getInstance();
    await sref.setString("cookieTime", "");
    await sref.setString("cookies", "");
  }
}

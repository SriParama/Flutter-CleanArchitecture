import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:novo_clean_arch/features/data/remote_data_source/api_remote_data_source.dart';
import 'package:novo_clean_arch/features/data/remote_data_source/model/dash_board_model.dart';
import 'package:novo_clean_arch/features/domin/entities/dash_board_entity.dart';
import 'package:novo_clean_arch/features/domin/entities/forgetPwd_entity.dart';
import 'package:novo_clean_arch/features/domin/entities/getOtp_enitity.dart';
import 'package:novo_clean_arch/features/domin/entities/login_entity.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/provider/setCookie_Provider.dart';

class ApiRemoteDataSourceImpl implements ApiRemoteDataSource {
  String mainUrl = 'https://novoapi.flattrade.in/';
  @override
  Future<void> login(LoginEntity login) async {
    await loginApi(
        login.clientId!, login.password!, login.pan!, 'webAuthlogin');
  }

  @override
  Future<bool> isLogin() async {
    return await verifyCookies();
  }

  @override
  Future<void> logOut() async {
    await deleteCookieInSref();
  }

  @override
  Future<bool> forgetPwd(ForgetPwdEntity forgetPwdEntity) async {
    return await forgetPwdApi(forgetPwdEntity.clientId!, forgetPwdEntity.pan!,
        forgetPwdEntity.dob!, forgetPwdEntity.sid!, 'ftAuthForgetPwd');
  }

  @override
  Future<bool> getOtp(GetOtpEntity getOtpEntity) async {
    return await getOtpApi(getOtpEntity.userId!, getOtpEntity.pan!, 'sentOTP');
  }

  @override
  Future<String> getCurrentCookie() async {
    if (await verifyCookies()) {
      return cookies;
    }

    return '';
  }

  @override
  Future<String> getClientId() async {
    return await getclientIdApi('tokenValidation');
  }

  @override
  Future<DashboardEntity> getDashBoardDetails() async {
    return await getMethod('dashboard');
  }

  Future<void> loginApi(
      String clientId, String password, String pan, String url) async {
    try {
      final response = await http.post(
        Uri.parse(mainUrl + url),
        body: jsonEncode({
          'clientId': clientId,
          'password': password,
          'otp': pan,
        }),
        headers: {
          'Origin': 'https://novo.flattrade.in',
          'Referer': 'https://novo.flattrade.in'
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 'S') {
          await updateCookie(response);
        }
      }
    } catch (e) {
      print("Error during login: $e");
    }
  }

  Future<bool> forgetPwdApi(
      String clientId, String pan, String dob, String sid, String url) async {
    try {
      var sidd = await getSessionId();
      // await getSessionId();
      print("sessionId");
      print(sidd);
      // var sessionId = await getSessionId();
      // print("sessionId");
      // print(sessionId);

      final response = await http.post(
        Uri.parse('https://authapi.flattrade.in/ftauthreset'),
        body: jsonEncode(
            {'UserName': clientId, 'PAN': pan, 'DOB': dob, 'sid': sidd}),
        headers: {
          'Origin': 'https://novo.flattrade.in',
          'Referer': 'https://novo.flattrade.in'
        },
      );
      print('$mainUrl$url');
      Map fdetail = {'UserName': clientId, 'PAN': pan, 'DOB': dob, 'sid': sidd};
      print(fdetail);
      print("response.body");
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("jsonResponse");
        print(jsonResponse);
        if (jsonResponse['emsg'] == "") {
          return true;
          // await updateCookie(response);
        } else {
          print(jsonResponse['emsg']);
          return false;
        }
      }
      return false;
    } catch (e) {
      print('catch' + e.toString());
      return false;
      // print("Error during login: $e");
    }
  }

  Future<bool> getOtpApi(String clientId, String pan, String url) async {
    try {
      var sid = await getSessionId();
      print("sessionId");
      print(sid);

      final response = await http.put(
        Uri.parse('https://authapi.flattrade.in/sendOTP'),
        body: jsonEncode(
            {'UserName': clientId, 'PAN': pan, 'sid': "", 'Sid': sid}),
        headers: {
          'Origin': 'https://novo.flattrade.in',
          'Referer': 'https://novo.flattrade.in'
        },
      );
      print('$mainUrl$url');
      Map fdetail = {'UserName': clientId, 'PAN': pan, 'sid': "", 'Sid': sid};
      print(fdetail);
      print("response.body");
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("jsonResponse");
        print(jsonResponse);
        if (jsonResponse['emsg'] == "") {
          return true;
          // await updateCookie(response);
        } else {
          print(jsonResponse['emsg']);
          return false;
        }
      }
      return false;
    } catch (e) {
      print('catch' + e.toString());
      return false;
      // print("Error during login: $e");
    }
  }

  // String sessionId = '';
  Future<String> getSessionId() async {
    Map<String, String> headers = {
      'Origin': 'https://auth.flattrade.in',
      'Referer': 'https://auth.flattrade.in'

      // 'Origin': 'http://localhost:8080',
      // 'Referer': 'http://localhost:8080'
    };
    try {
      var response = await http.post(
          Uri.parse("https://authapi.flattrade.in/auth/session"),
          headers: headers);
      // var response = await http.post(
      //     Uri.parse("http://192.168.02.101:29091/auth/session"),
      // headers: headers);
      if (response.statusCode == 200) {
        // print(response.body);
        // sessionId = response.body;
        return response.body;
      } else {
        return '';
      }
    } catch (e) {
      print('Your SessionID Exception is $e');
      return '';
    }
  }

  String cookies = '';
  String cookieTime = '';

  Future<void> updateCookie(http.Response response) async {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null && rawCookie.isNotEmpty) {
      DateTime validateTime = DateTime.now().add(Duration(
          seconds:

              // 20
              int.parse(
                  rawCookie.split(";").toList()[3].split("=").toList()[1])));
      print(validateTime);
      SharedPreferences sref = await SharedPreferences.getInstance();

      await sref.setString("cookieTime", validateTime.toString());
      await sref.setString("cookies", rawCookie);
      cookies = rawCookie;
    }
  }

  Future<bool> verifyCookies() async {
    SharedPreferences sref = await SharedPreferences.getInstance();
    cookies = sref.getString("cookies") ?? "";
    cookieTime = sref.getString("cookieTime") ?? "";
    if (cookieTime.isEmpty ||
        cookies.isEmpty ||
        DateTime.parse(cookieTime).difference(DateTime.now()).inMicroseconds <
            0) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> deleteCookieInSref() async {
    SharedPreferences sref = await SharedPreferences.getInstance();

    await sref.setString("cookieTime", "");
    await sref.setString("cookies", "");
  }

  Future<DashboardEntity> getMethod(String url) async {
    http.Response response = await http.get(Uri.parse("$mainUrl$url"),
        headers: {"cookie": cookies, 'User-Agent': 'YourApp/1.0 (APP)'});
    print("response.body");
    print(response.body);
    return DashboardEntity.fromJson(jsonDecode(response.body));
  }

  Future<String> getclientIdApi(String url) async {
    http.Response response =
        await http.get(Uri.parse("$mainUrl$url"), headers: {"cookie": cookies});

    print(response.body);
    Map json = jsonDecode(response.body);

    if (json['status'] == 'S') {
      return json['clientId'];
    } else {
      return '';
    }
  }

  // return response;
}

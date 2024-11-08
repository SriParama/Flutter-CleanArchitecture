import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:novoapp/core/utils/end_point_address.dart';
import 'package:novoapp/core/utils/global_const.dart';
import 'package:http/http.dart' as http;
import 'package:novoapp/core/utils/shared_pref.dart';

Future<Map<String, dynamic>> loginApi(
  String clientId,
  String password,
  String pan,
) async {
  try {
    var bytes = utf8.encode(password); // Convert the input string to bytes
    var hash = sha256.convert(bytes);
    final response = await http.post(
      Uri.parse("${ApiAddress.mainApiAddress}${ApiEndPoint.webAuthlogin}"),
      body: jsonEncode({
        'clientId': clientId,
        'password': hash.toString(),
        'otp': pan,
      }),
      headers: ApiAddress.mainApiHeaders,
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      SharedPrefRepository().updateCookie(response);

      return jsonResponse;
    } else {
      throw Exception(AppContsTexts.failed);
    }
  } on http.ClientException {
    throw AppContsTexts.socketExeption;
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<String> getSessionId() async {
  // Map<String, String> headers = {
  //   'Origin': 'https://auth.flattrade.in',
  //   'Referer': 'https://auth.flattrade.in'
  // };
  try {
    var response = await http.post(
        Uri.parse("${ApiAddress.authMainApiAddress}${ApiEndPoint.session}"),
        headers: ApiAddress.authMainApiHeaders);
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return '';
    }
  } catch (e) {
    ////print('Your SessionID Exception is $e');
    return '';
  }
}

Future<Map<String, dynamic>> forgetPwdApi(
    String clientId, String pan, String dob, String sid) async {
  try {
    // Map<String, String> headers = {
    //   'Origin': 'https://auth.flattrade.in',
    //   'Referer': 'https://auth.flattrade.in'
    // };
    var sid = await getSessionId();
    // Map data = {'UserName': clientId, 'PAN': pan, 'DOB': dob, 'sid': sid};
    ////print(data);
    final response = await http.post(
      Uri.parse("${ApiAddress.authMainApiAddress}${ApiEndPoint.ftauthreset}"),
      body: jsonEncode(
          {'UserName': clientId, 'PAN': pan, 'DOB': dob, 'sid': sid}),
      headers: ApiAddress.authMainApiHeaders,
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    } else {
      throw Exception(AppContsTexts.failed);
    }
  } on http.ClientException {
    throw AppContsTexts.internetFailed;
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<Map<String, dynamic>> getOtpApi(
    String clientId, String pan, String sid, String sid1) async {
  try {
    // Map<String, String> headers = {
    //   'Origin': 'https://auth.flattrade.in',
    //   'Referer': 'https://auth.flattrade.in'

    //   // 'Origin': 'http://localhost:8080',
    //   // 'Referer': 'http://localhost:8080'
    // };
    var sid = await getSessionId();
    final response = await http.put(
      Uri.parse('${ApiAddress.authMainApiAddress}${ApiEndPoint.sendOTP}'),
      body:
          jsonEncode({'UserName': clientId, 'PAN': pan, 'sid': "", 'Sid': sid}),
      headers: ApiAddress.authMainApiHeaders,
    );
    print({'UserName': clientId, 'PAN': pan, 'sid': "", 'Sid': sid});
    print(response);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    } else {
      throw Exception(AppContsTexts.failed);
    }
  } on http.ClientException {
    throw AppContsTexts.internetFailed;
  } catch (e) {
    throw Exception(e.toString());
  }
}

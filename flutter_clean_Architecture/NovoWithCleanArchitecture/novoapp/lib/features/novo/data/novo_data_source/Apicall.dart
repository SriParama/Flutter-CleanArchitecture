// import 'dart:convert';

import 'dart:convert';

import 'package:novoapp/core/utils/end_point_address.dart';
import 'models/dashboard_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<http.Response> getCookieApi(String url) async {
  SharedPreferences sref = await SharedPreferences.getInstance();
  String cookies = sref.getString("cookies") ?? "";
  http.Response response = await http
      .get(Uri.parse("${EndPointAddress.mainApiAddress}$url"), headers: {
    "cookie": cookies,
    'User-Agent': 'YourApp/1.0 (APP)',
    ...EndPointAddress.mainApiHeaders
  });
  return response;
}

Future<DashboardModel> getDashboardApi(String url) async {
  http.Response response = await getCookieApi(url);
  return DashboardModel.fromJson(jsonDecode(response.body));
}

Future<String> getclientIdApi(String url) async {
  http.Response response = await getCookieApi(url);
  Map json = jsonDecode(response.body);

  if (json['status'] == 'S') {
    return json['clientId'];
  } else {
    return '';
  }
}

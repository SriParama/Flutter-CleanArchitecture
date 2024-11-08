import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flattrade/core/common/common_methods.dart';
import 'package:flattrade/core/error/failure.dart';
import 'package:flattrade/core/utils/end_point_address.dart';
import 'package:flattrade/core/utils/text_contants.dart';
import 'package:flattrade/features/auth/data/datasource/remote_data_sources.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<Map<String, dynamic>> logIN(
    String factor, {
    required String userId,
    required String password,
  }) async {
    try {
      var bytes = utf8.encode(password); // Convert the input string to bytes
      var hash = sha256.convert(bytes); //
      var userdetials = {
        'uid': userId,
        'pwd': hash.toString(),
        'factor2': factor,
        'addldivivf': await CommonMethods.getLocalIpAddress(),
        'ipaddr': CommonMethods.getDeviceType(),
        'source': 'API',
      };
      http.Response response = await http.Client().post(
          Uri.parse('${EndPointAddress.apiAddress}quickAuth'),
          body: jsonEncode(userdetials));
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        // if (responseData["quickauthresp"]['stat'] == 'Ok') {
        //   await TokenRepository().saveToken(
        //       responseData["quickauthresp"]['susertoken'],
        //       responseData["quickauthresp"]['actid']);
        // }

        return responseData;
      } else {
        throw Exception(APPTextConstants.failure);
      }
    } on http.ClientException {
      throw APPTextConstants.failed;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> logInWithOtp({
    required String userId,
    required String password,
  }) async {
    try {
      var bytes = utf8.encode(password);
      var hash = sha256.convert(bytes);
      for (var i = 0; i < 2; i++) {
        var bytes = utf8.encode(hash.toString());
        hash = sha256.convert(bytes);
      }
      var jsonData = {"uid": userId, "pan": hash.toString()};

      http.Response response = await http.post(
          Uri.parse('${EndPointAddress.apiAddress}fgtPwdOTP'),
          body: jsonEncode(jsonData));
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData;
      } else {
        throw Exception(Failure(APPTextConstants.failure));
      }
    } catch (e) {
      throw Exception(Failure().message);
    }
  }

  @override
  Future<void> changePassword({
    required String userid,
    required String oldPassword,
    required String newPassword,
  }) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> forgetPassword({
    required String userid,
    required String pan,
    required String dob,
  }) async {
    try {
      String url = '${EndPointAddress.apiAddress}forgotPassword';
      var jsonData = {
        "uid": userid,
        "pan": pan,
        "dob": dob,
      };
      print(jsonData);
      http.Response response = await http.post(Uri.parse(url), body: jsonEncode(jsonData));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        return responseData;
      } else {
        throw Exception(Failure(APPTextConstants.failure));
      }
    } catch (e) {
      throw Exception(Failure().message);
    }
  }
}
// {
//     "response": {
//         "request_time": "",
//         "stat": "",
//         "emsg": ""
//     },
//     "status": "E",
//     "errMsg": "Invalid Input :  Invalid DOB"
// }

// {
//     "response": {
//         "request_time": "",
//         "stat": "",
//         "emsg": ""
//     },
//     "status": "E",
//     "errMsg": "Error Occurred : Wrong user id or user details"
// }


// {
//     "response": {
//         "request_time": "15:20:15 04-05-2024",
//         "stat": "Ok",
//         "emsg": ""
//     },
//     "status": "S",
//     "errMsg": ""
// }
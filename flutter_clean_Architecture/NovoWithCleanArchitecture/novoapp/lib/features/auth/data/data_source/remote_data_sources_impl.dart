import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:novoapp/core/utils/shared_pref.dart';
import 'package:novoapp/features/auth/data/data_source/ApiCall.dart';
import 'package:novoapp/features/auth/data/data_source/remote_data_sources.dart';
import 'package:novoapp/features/auth/domine/enities/forgetpwd_enitity.dart';
import 'package:novoapp/features/auth/domine/enities/getotp_enitity.dart';
import 'package:novoapp/features/auth/domine/enities/login_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<Map<String, dynamic>> logIn(LoginEntity login) async {
    return await loginApi(
        login.clientId!, login.password!, login.pan!, 'webAuthlogin');
  }

  @override
  Future<Map<String, dynamic>> forgetPwd(
      ForgetPwdEntity forgetPwdEntity) async {
    return await forgetPwdApi(forgetPwdEntity.clientId!, forgetPwdEntity.pan!,
        forgetPwdEntity.dob!, forgetPwdEntity.sid!);
  }

  @override
  Future<Map<String, dynamic>> getOtp(GetOtpEntity getOtpEntity) async {
    return await getOtpApi(getOtpEntity.clientId!, getOtpEntity.pan!,
        getOtpEntity.sid!, getOtpEntity.sid1!);
  }

  @override
  Future<bool> isLoggedIn() async {
    return await SharedPrefRepository().verifyCookies();
  }

  // @override
  // Future<String> getCurrentCookie() async {
  //   if (await SharedPrefRepository().verifyCookies()) {
  //     SharedPreferences sref = await SharedPreferences.getInstance();
  //     String cookies = sref.getString("cookies") ?? "";
  //     // String cookies =
  //     //     Provider.of<SharedPrefRepository>(context, listen: false).cookies;
  //     return cookies;
  //   } else {
  //     return '';
  //   }
  // }

  @override
  Future<bool> logout() async {
    await SharedPrefRepository().deleteCookieInSref();
    return true;
  }
}

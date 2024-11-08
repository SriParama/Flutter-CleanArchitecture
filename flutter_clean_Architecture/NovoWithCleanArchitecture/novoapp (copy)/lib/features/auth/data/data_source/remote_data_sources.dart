import 'package:novoapp/features/auth/domine/enities/forgetpwd_enitity.dart';
import 'package:novoapp/features/auth/domine/enities/getotp_enitity.dart';

import '../../domine/enities/login_entity.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> logIn(LoginEntity login);
  Future<Map<String, dynamic>> forgetPwd(ForgetPwdEntity forgetPwdEntity);
  Future<Map<String, dynamic>> getOtp(GetOtpEntity getOtpEntity);
  Future<bool> isLoggedIn();
  // Future<String> getCurrentCookie();
  Future<bool> logout();
}

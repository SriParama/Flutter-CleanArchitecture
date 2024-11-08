import 'package:fpdart/fpdart.dart';
import 'package:novoapp/core/error/failure.dart';
import 'package:novoapp/features/auth/domine/enities/forgetpwd_enitity.dart';
import 'package:novoapp/features/auth/domine/enities/getotp_enitity.dart';
import 'package:novoapp/features/auth/domine/enities/login_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, Map<String, dynamic>>> logIn(LoginEntity loginEntity);
  Future<Either<Failure, Map<String, dynamic>>> fotgetPwd(
      ForgetPwdEntity forgetPwdEntity);
  Future<Either<Failure, Map<String, dynamic>>> getOtp(
      GetOtpEntity getOtpEntity);
  Future<bool> isLoggedIn();
  // Future<String> getCurrentCookie();
  Future<bool> logout();
}

import 'package:fpdart/src/either.dart';
import 'package:novoapp/core/error/failure.dart';
import 'package:novoapp/features/auth/data/data_source/remote_data_sources.dart';
import 'package:novoapp/features/auth/domine/auth_repository/auth_repository.dart';
import 'package:novoapp/features/auth/domine/enities/forgetpwd_enitity.dart';
import 'package:novoapp/features/auth/domine/enities/getotp_enitity.dart';
import 'package:novoapp/features/auth/domine/enities/login_entity.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, Map<String, dynamic>>> logIn(
      LoginEntity loginEntity) async {
    try {
      var res = await authRemoteDataSource.logIn(loginEntity);

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fotgetPwd(
      ForgetPwdEntity forgetPwdEntity) async {
    try {
      var res = await authRemoteDataSource.forgetPwd(forgetPwdEntity);

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getOtp(
      GetOtpEntity getOtpEntity) async {
    try {
      var res = await authRemoteDataSource.getOtp(getOtpEntity);

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // @override
  // Future<String> getCurrentCookie() async {
  //   try {
  //     var res = await authRemoteDataSource.getCurrentCookie();

  //     return res;
  //   } catch (e) {
  //     return '';
  //   }
  // }

  @override
  Future<bool> isLoggedIn() async {
    try {
      var res = await authRemoteDataSource.isLoggedIn();
      if (res) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      var res = await authRemoteDataSource.logout();
      if (res) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

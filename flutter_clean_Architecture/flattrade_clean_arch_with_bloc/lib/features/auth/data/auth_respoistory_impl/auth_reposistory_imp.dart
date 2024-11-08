import 'package:flattrade/core/error/failure.dart';
import 'package:flattrade/features/auth/data/datasource/remote_data_sources.dart';
import 'package:flattrade/features/auth/domain/auth_reposistory/auth_resposistory.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImp extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImp({
    required this.authRemoteDataSource,
  });
  @override
  Future<Either<Failure, Map<String, dynamic>>> logIN(
    String factor, {
    required String userId,
    required String password,
  }) async {
    try {
      var res = await authRemoteDataSource.logIN(factor,
          userId: userId, password: password);

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getOtp({
    required String userId,
    required String password,
  }) async {
    try {
      var res = await authRemoteDataSource.logInWithOtp(
          userId: userId, password: password);

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> forgetPasaword({
    required String userId,
    required String pan,
    required String dob,
  }) async {
    try {
      var res = await authRemoteDataSource.forgetPassword(
        userid: userId,
        pan: pan,
        dob: dob,
      );

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

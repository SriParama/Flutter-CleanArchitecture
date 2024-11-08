import 'package:flattrade/core/error/failure.dart';
import 'package:flattrade/core/usecase/usecase.dart';
import 'package:flattrade/features/auth/domain/auth_reposistory/auth_resposistory.dart';
import 'package:fpdart/fpdart.dart';

class ClientLogin implements UseCase<Map<String, dynamic>, UserLoginParams> {
  final AuthRepository authRepository;

  ClientLogin({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(params) async {
    return await authRepository.logIN(
      params.factor??"",
      userId: params.userId,
      password: params.password,
    );
  }
}



class UserLoginParams {
  final String userId;
  final String password;
  String ?factor;

  UserLoginParams(
    this.factor, {
    required this.userId,
    required this.password,
  });
}

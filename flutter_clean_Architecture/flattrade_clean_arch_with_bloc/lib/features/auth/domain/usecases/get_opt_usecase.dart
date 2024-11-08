import 'package:flattrade/core/error/failure.dart';
import 'package:flattrade/core/usecase/usecase.dart';
import 'package:flattrade/features/auth/domain/auth_reposistory/auth_resposistory.dart';
import 'package:flattrade/features/auth/domain/usecases/client_login_usecase.dart';
import 'package:fpdart/fpdart.dart';

class GetOtp implements UseCase<Map<String, dynamic>, UserLoginParams> {
  final AuthRepository authRepository;

  GetOtp({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(params) async {
    return await authRepository.getOtp(
      userId: params.userId,
      password: params.password,
    );
  }
}

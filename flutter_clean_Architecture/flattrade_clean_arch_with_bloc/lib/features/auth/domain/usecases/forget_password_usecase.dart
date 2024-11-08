import 'package:flattrade/core/error/failure.dart';
import 'package:flattrade/core/usecase/usecase.dart';
import 'package:flattrade/features/auth/domain/auth_reposistory/auth_resposistory.dart';
import 'package:fpdart/fpdart.dart';

class ForgetPasswordUsecase
    implements UseCase<Map<String, dynamic>, UserForgetPasswordParams> {
  final AuthRepository authRepository;

  ForgetPasswordUsecase({required this.authRepository});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      UserForgetPasswordParams params) async {
    return await authRepository.forgetPasaword(
      userId: params.userId,
      pan: params.pan,
      dob: params.dob,
    );
  }
}

class UserForgetPasswordParams {
  final String userId;
  final String pan;
  final String dob;

  UserForgetPasswordParams({
    required this.userId,
    required this.pan,
    required this.dob,
  });
}

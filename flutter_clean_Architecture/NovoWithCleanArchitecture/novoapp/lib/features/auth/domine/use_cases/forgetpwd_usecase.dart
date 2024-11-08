import 'package:fpdart/fpdart.dart';
import 'package:novoapp/core/error/failure.dart';
import 'package:novoapp/core/usecase/usecase.dart';
import 'package:novoapp/features/auth/domine/auth_repository/auth_repository.dart';
import 'package:novoapp/features/auth/domine/enities/forgetpwd_enitity.dart';

class ForgetPwdUseCase
    implements UseCase<Map<String, dynamic>, ForgetPwdEntity> {
  final AuthRepository authRepository;

  ForgetPwdUseCase({required this.authRepository});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      ForgetPwdEntity forgetPwdEntity) async {
    return await authRepository.fotgetPwd(forgetPwdEntity);
  }
}

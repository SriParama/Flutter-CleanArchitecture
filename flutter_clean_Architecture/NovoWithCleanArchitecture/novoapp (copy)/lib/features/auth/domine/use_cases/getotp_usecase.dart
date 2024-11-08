import 'package:fpdart/fpdart.dart';
import 'package:novoapp/core/error/failure.dart';
import 'package:novoapp/core/usecase/usecase.dart';
import 'package:novoapp/features/auth/domine/auth_repository/auth_repository.dart';
import 'package:novoapp/features/auth/domine/enities/forgetpwd_enitity.dart';
import 'package:novoapp/features/auth/domine/enities/getotp_enitity.dart';

class GetOtpUseCase implements UseCase<Map<String, dynamic>, GetOtpEntity> {
  final AuthRepository authRepository;

  GetOtpUseCase({required this.authRepository});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      GetOtpEntity getOtpEntity) async {
    return await authRepository.getOtp(getOtpEntity);
  }
}

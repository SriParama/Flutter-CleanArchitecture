import 'package:novo_clean_arch/features/domin/entities/forgetPwd_entity.dart';
import 'package:novo_clean_arch/features/domin/entities/getOtp_enitity.dart';
import 'package:novo_clean_arch/features/domin/repositories/api_repository.dart';

class GetOtpUseCase {
  final ApiRepository repository;
  GetOtpUseCase({required this.repository});
  Future<bool> call(GetOtpEntity getOtpEntity) async {
    // print(await repository.login(login));
    return await repository.getOtp(getOtpEntity);
  }
}

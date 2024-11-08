import 'package:novo_clean_arch/features/domin/entities/forgetPwd_entity.dart';
import 'package:novo_clean_arch/features/domin/repositories/api_repository.dart';

class ForgetPwdUseCase {
  final ApiRepository repository;
  ForgetPwdUseCase({required this.repository});
  Future<bool> call(ForgetPwdEntity forgetPwdEntity) async {
    // print(await repository.login(login));
    return await repository.forgetPwd(forgetPwdEntity);
  }
}

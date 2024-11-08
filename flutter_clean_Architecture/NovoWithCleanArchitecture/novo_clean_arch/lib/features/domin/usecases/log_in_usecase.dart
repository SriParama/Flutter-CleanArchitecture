import 'package:flutter/widgets.dart';
import 'package:novo_clean_arch/features/domin/entities/login_entity.dart';
import 'package:novo_clean_arch/features/domin/repositories/api_repository.dart';

class LoginUseCase {
  final ApiRepository repository;
  LoginUseCase({required this.repository});
  Future<void> login(LoginEntity login) async {
    // print(await repository.login(login));
    return await repository.login(login);
  }
}

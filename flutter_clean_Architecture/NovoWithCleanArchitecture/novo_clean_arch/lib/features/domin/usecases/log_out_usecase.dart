import 'package:novo_clean_arch/features/domin/repositories/api_repository.dart';

class LogOutUseCase {
  final ApiRepository repository;

  LogOutUseCase({required this.repository});

  Future<void> logOut() {
    return repository.logOut();
  }
}

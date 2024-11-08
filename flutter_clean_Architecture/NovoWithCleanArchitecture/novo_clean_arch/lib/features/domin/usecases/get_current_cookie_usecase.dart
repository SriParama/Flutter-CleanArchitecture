import 'package:novo_clean_arch/features/domin/repositories/api_repository.dart';

class GetCurrentCookieUseCase {
  final ApiRepository repository;

  GetCurrentCookieUseCase({required this.repository});

  Future<String> call() async {
    return await repository.getCurrentCookie();
  }
}

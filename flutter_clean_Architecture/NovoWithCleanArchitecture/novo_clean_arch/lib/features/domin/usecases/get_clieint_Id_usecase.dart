import '../repositories/api_repository.dart';

class GetClientIDUseCase {
  final ApiRepository repository;

  GetClientIDUseCase({required this.repository});

  Future<String> call() async {
    return await repository.getClientId();
  }
}

import 'package:novoapp/features/novo/domine/novo_repository/novo_repository.dart';

class GetClientIDUseCase {
  final NovoRepository repository;

  GetClientIDUseCase({required this.repository});

  Future<String> call() async {
    return await repository.getClientId();
  }
}

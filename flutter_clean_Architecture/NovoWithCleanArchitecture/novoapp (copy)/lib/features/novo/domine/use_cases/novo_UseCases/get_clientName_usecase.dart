import 'package:novoapp/features/novo/domine/novo_repository/novo_repository.dart';

class GetClientNameUseCase {
  final NovoRepository repository;

  GetClientNameUseCase({required this.repository});

  Future<String> call() async {
    try {
      return await repository.getClientName();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error in GetClientNameUseCase: $e');
      // Re-throw the exception to be handled by the caller
      throw Exception('Failed to get ClientName details');
    }
  }
}

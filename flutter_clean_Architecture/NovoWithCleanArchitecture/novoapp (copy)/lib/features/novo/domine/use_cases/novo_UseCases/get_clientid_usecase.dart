import 'package:novoapp/features/novo/domine/novo_repository/novo_repository.dart';

class GetClientIDUseCase {
  final NovoRepository repository;

  GetClientIDUseCase({required this.repository});

  Future<String> call() async {
    try {
      return await repository.getClientId();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error in GetDashBoardUseCase: $e');
      // Re-throw the exception to be handled by the caller
      throw Exception('Failed to get ClientID details');
    }
  }
}

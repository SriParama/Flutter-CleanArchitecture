import 'package:novoapp/features/novo/domine/novo_repository/novo_repository.dart';

class GetAccountBalanceUseCase {
  final NovoRepository repository;

  GetAccountBalanceUseCase({required this.repository});

  Future<dynamic> getSGBinvestDetailsUseCase() async {
    try {
      return await repository.getAccountBalanceDetails();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error in GetSbgMasterDatailsUseCase: $e');
      // Re-throw the exception to be handled by the caller
      throw Exception('Failed to fetch fund details');
    }
  }
}

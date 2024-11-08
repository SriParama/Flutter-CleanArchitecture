import 'package:novoapp/features/novo/data/novo_data_source/models/gsecModel/gsecInvestModel.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_InvestDetails_model.dart';
import 'package:novoapp/features/novo/domine/novo_repository/novo_repository.dart';

class GetGsecinvestDatailsUseCase {
  final NovoRepository repository;

  GetGsecinvestDatailsUseCase({required this.repository});

  Future<GsecInvestDetailsModel> getGsecinvestDetailsUseCase() async {
    try {
      return await repository.getGsecinvestDetails();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error in GetSbgMasterDatailsUseCase: $e');
      // Re-throw the exception to be handled by the caller
      throw Exception('Failed to get gsec details');
    }
  }
}

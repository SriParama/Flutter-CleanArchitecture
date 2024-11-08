import 'package:novoapp/features/novo/data/novo_data_source/models/gsecModel/gsecorderdetails_model.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_OrderDetails_model.dart';
import 'package:novoapp/features/novo/domine/novo_repository/novo_repository.dart';

class GetGsecorderDatailsUseCase {
  final NovoRepository repository;

  GetGsecorderDatailsUseCase({required this.repository});

  Future<GsecOrderDetailsModel> getGsecorderDetailsUseCase() async {
    try {
      return await repository.getGsecorderDetails();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error in GetSbgMasterDatailsUseCase: $e');
      // Re-throw the exception to be handled by the caller
      throw Exception('Failed to get gsec Order details');
    }
  }
}

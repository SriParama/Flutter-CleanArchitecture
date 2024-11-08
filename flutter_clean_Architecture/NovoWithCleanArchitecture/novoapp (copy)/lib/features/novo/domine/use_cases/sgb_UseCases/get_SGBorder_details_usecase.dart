import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_OrderDetails_model.dart';
import 'package:novoapp/features/novo/domine/novo_repository/novo_repository.dart';

class GetSGBorderDatailsUseCase {
  final NovoRepository repository;

  GetSGBorderDatailsUseCase({required this.repository});

  Future<SGBorderDetialsModel> getSGBorderDetailsUseCase() async {
    try {
      return await repository.getSGBorderDetails();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error in GetSbgMasterDatailsUseCase: $e');
      // Re-throw the exception to be handled by the caller
      throw Exception('Failed to get sbg Order details');
    }
  }
}

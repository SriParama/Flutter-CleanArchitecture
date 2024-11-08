import 'package:novoapp/features/novo/data/novo_data_source/models/novoModel/dashboard_model.dart';
import 'package:novoapp/features/novo/domine/novo_repository/novo_repository.dart';

class GetDashBoardUseCase {
  final NovoRepository repository;

  GetDashBoardUseCase({required this.repository});

  Future<DashboardModel> getDashDetailsUseCase() async {
    try {
      return await repository.getDashBoardDetails();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error in GetDashBoardUseCase: $e');
      // Re-throw the exception to be handled by the caller
      throw Exception('Failed to get dashboard details');
    }
  }
}

import 'package:novoapp/features/novo/data/novo_data_source/models/dashboard_model.dart';
import 'package:novoapp/features/novo/domine/novo_repository/novo_repository.dart';

class GetDashBoardUseCase {
  final NovoRepository repository;

  GetDashBoardUseCase({required this.repository});

  Future<DashboardModel> getDashDetailsUseCase() async {
    return await repository.getDashBoardDetails();
  }
}

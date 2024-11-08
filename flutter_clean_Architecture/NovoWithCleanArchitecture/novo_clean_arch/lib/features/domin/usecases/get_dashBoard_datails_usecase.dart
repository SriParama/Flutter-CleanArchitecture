import 'package:novo_clean_arch/features/data/remote_data_source/api_remote_data_source.dart';
import 'package:novo_clean_arch/features/data/remote_data_source/model/dash_board_model.dart';
import 'package:novo_clean_arch/features/domin/entities/dash_board_entity.dart';

import '../repositories/api_repository.dart';

class GetDashBoardDataUseCase {
  final ApiRepository repository;

  GetDashBoardDataUseCase({required this.repository});

  Future<DashboardEntity> getDashDetailUseCase() async {
    return await repository.getDashBoardDetails();
  }
}

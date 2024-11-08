import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/novoModel/dashboard_model.dart';
import 'package:novoapp/features/novo/domine/use_cases/novo_UseCases/getDashBoard_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/novo_UseCases/get_clientName_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/novo_UseCases/get_clientid_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/sgb_UseCases/getAccountBalance_usecase.dart';

part 'fetch_data_state.dart';

class FetchDataCubit extends Cubit<FetchDataState> {
  final GetDashBoardUseCase getDashBoardUseCase;
  final GetClientIDUseCase getClientIDUseCase;
  final GetClientNameUseCase getClientNameUseCase;

  FetchDataCubit({
    required this.getDashBoardUseCase,
    required this.getClientIDUseCase,
    required this.getClientNameUseCase,
  }) : super(FetchDataInitial());

  Future<void> getDashBoardData(
      // {required DashBoardEntity dashBoardEntity}
      ) async {
    emit(FetchDataInitial());
    try {
      final dashboard = await getDashBoardUseCase.getDashDetailsUseCase();
      final clientId = await getClientIDUseCase.call();
      final clientName = await getClientNameUseCase.call();

      emit(FetchDataLoaded(
          dashboardData: dashboard,
          clientId: clientId,
          clientName: clientName));
    } on SocketException catch (_) {
      emit(FetchDataFailure());
    } catch (_) {
      emit(FetchDataFailure());
    }
  }
}

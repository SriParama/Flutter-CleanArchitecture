import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/dashboard_model.dart';
import 'package:novoapp/features/novo/domine/use_cases/getDashBoard_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/get_clientid_usecase.dart';

part 'fetch_data_state.dart';

class FetchDataCubit extends Cubit<FetchDataState> {
  final GetDashBoardUseCase getDashBoardUseCase;
  final GetClientIDUseCase getClientIDUseCase;

  FetchDataCubit(
      {required this.getDashBoardUseCase, required this.getClientIDUseCase})
      : super(FetchDataInitial());

  Future<void> getDashBoardData(
      // {required DashBoardEntity dashBoardEntity}
      ) async {
    emit(FetchDataInitial());
    try {
      final dashboard = await getDashBoardUseCase.getDashDetailsUseCase();
      final clientId = await getClientIDUseCase.call();
      emit(FetchDataLoaded(dashboardData: dashboard, clientId: clientId));
    } on SocketException catch (_) {
      emit(FetchDataFailure());
    } catch (_) {
      emit(FetchDataFailure());
    }
  }
}

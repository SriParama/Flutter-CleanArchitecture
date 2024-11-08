import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novo_clean_arch/features/data/remote_data_source/model/dash_board_model.dart';
import 'package:novo_clean_arch/features/domin/entities/dash_board_entity.dart';
import 'package:novo_clean_arch/features/domin/usecases/get_clieint_Id_usecase.dart';
import 'package:novo_clean_arch/features/domin/usecases/get_clieint_Id_usecase.dart';
import 'package:novo_clean_arch/features/domin/usecases/get_dashBoard_datails_usecase.dart';

part 'fetch_state.dart';

class FetchCubit extends Cubit<FetchState> {
  final GetDashBoardDataUseCase getDashBoardDataUseCase;
  final GetClientIDUseCase getClientIDUseCase;

  FetchCubit(
      {required this.getDashBoardDataUseCase, required this.getClientIDUseCase})
      : super(FetchInitial());

  Future<void> getDashBoardData(
      // {required DashBoardEntity dashBoardEntity}
      ) async {
    print('Loading');
    emit(FetchLoading());
    try {
      final dashboard = await getDashBoardDataUseCase.getDashDetailUseCase();
      final clientId = await getClientIDUseCase.call();
      print('Success');

      // emit(FetchLoaded(
      //     dashboardData: await getDashBoardDataUseCase.getDashDetailUseCase()));
      emit(FetchLoaded(dashboardData: dashboard, clientId: clientId));
    } on SocketException catch (_) {
      emit(FetchFailure());
    } catch (_) {
      emit(FetchFailure());
    }
  }
}

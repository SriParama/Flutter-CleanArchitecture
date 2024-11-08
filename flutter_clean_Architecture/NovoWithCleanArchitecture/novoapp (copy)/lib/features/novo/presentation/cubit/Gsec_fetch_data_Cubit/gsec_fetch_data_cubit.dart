import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/gsecModel/gsecInvestModel.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/gsecModel/gsecorderdetails_model.dart';
import 'package:novoapp/features/novo/domine/use_cases/gsec_useCases/get_GsecMaster_details_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/gsec_useCases/get_Gsecorder_details_usecase.dart';

part 'gsec_fetch_data_state.dart';

class GsecFetchDataCubit extends Cubit<GsecFetchDataState> {
  final GetGsecinvestDatailsUseCase getGsecinvestDatailsUseCase;
  final GetGsecorderDatailsUseCase getGsecorderDatailsUseCase;
  GsecFetchDataCubit(
      {required this.getGsecinvestDatailsUseCase,
      required this.getGsecorderDatailsUseCase})
      : super(GsecFetchDataInitial());

  Future<void> getGsecData() async {
    // emit(G)
    getGsecInvestData();
    getGsecOrderData();
  }

  Future<void> getGsecInvestData() async {
    emit(GsecInvestDataLoading());

    try {
      final gsecInvestDetails =
          await getGsecinvestDatailsUseCase.getGsecinvestDetailsUseCase();
      // print('getinvestdata');
      // print(gsecInvestDetails.disclaimer);
      emit(GsecInvestDataLoaded(gsecInvestDetailsModel: gsecInvestDetails));
    } catch (e) {
      print(e);
      emit(GsecInvestDataFailed());
    }
  }

  Future<void> getGsecOrderData() async {
    emit(GsecOrderDataLoading());
    try {
      final gsecOrderDetails =
          await getGsecorderDatailsUseCase.getGsecorderDetailsUseCase();
      emit(GsecOrderDataLoaded(gsecOrderDetailsModel: gsecOrderDetails));
    } catch (e) {
      print(e);
      emit(GsecOrderDataFailed());
    }
  }
}

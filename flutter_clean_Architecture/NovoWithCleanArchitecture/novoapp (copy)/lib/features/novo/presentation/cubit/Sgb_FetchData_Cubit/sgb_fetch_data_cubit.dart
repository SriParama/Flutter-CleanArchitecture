import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_OrderDetails_model.dart';
import 'package:novoapp/features/novo/domine/use_cases/sgb_UseCases/getAccountBalance_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/sgb_UseCases/get_SGBorder_details_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/sgb_UseCases/get_SgbMaster_details_usecase.dart';

import '../../../data/novo_data_source/models/sgbModel/sgb_InvestDetails_model.dart';

part 'sgb_fetch_data_state.dart';

class SgbFetchDataCubit extends Cubit<SgbFetchDataState> {
  final GetSGBinvestDatailsUseCase getSGBinvestDatailsUseCase;
  final GetSGBorderDatailsUseCase getSGBorderDatailsUseCase;
  final GetAccountBalanceUseCase getAccountBalanceUseCase;
  SgbFetchDataCubit({
    required this.getSGBinvestDatailsUseCase,
    required this.getSGBorderDatailsUseCase,
    required this.getAccountBalanceUseCase,
  }) : super(SgbFetchDataInitial());

  Future<void> getSGBData() async {
    emit(SgbFetchDataInitial());
    try {
      final sgbInvestDetails =
          await getSGBinvestDatailsUseCase.getSGBinvestDetailsUseCase();
      final sgbFetchFund =
          await getAccountBalanceUseCase.getSGBinvestDetailsUseCase();
      emit(SGBinvestDataLoaded(
        sgbInvestDetailsModel: sgbInvestDetails,
        sgbFetchFund: sgbFetchFund,
      ));
      print("1111111111");
      print(sgbInvestDetails);

      final sgbOrderDetails =
          await getSGBorderDatailsUseCase.getSGBorderDetailsUseCase();

      emit(SGBorderDataLoaded(
          sgbInvestDetailsModel: sgbInvestDetails,
          sgbOrderDetialsModel: sgbOrderDetails,
          sgbFetchFund: sgbFetchFund));
      print("222222222");
      print(sgbOrderDetails.status);
    } on SocketException catch (_) {
      emit(SGBinvestDataFailure());
    } on Exception catch (e) {
      print('SGB catch exception: $e');
      emit(SGBorderDataFailure());
    }
  }
}

// Future<void> getSGBData(
  //     // {required DashBoardEntity dashBoardEntity}
  //     ) async {
  //   emit(SgbFetchDataInitial());
  //   try {
  //     final sgbInvestDetails =
  //         await getSGBinvestDatailsUseCase.getSGBinvestDetailsUseCase();
  //     emit(SGBinvestDataLoaded(sgbInvestDetailsModel: sgbInvestDetails));
  //     print("1111111111");
  //     print(sgbInvestDetails);
  //     // final sgbOrderDetails =
  //     //     await getSGBorderDatailsUseCase.getSGBorderDetailsUseCase();

  //     // final results = await Future.wait([
  //     //   getSGBinvestDatailsUseCase.getSGBinvestDetailsUseCase(),
  //     //   getSGBorderDatailsUseCase.getSGBorderDetailsUseCase(),
  //     // ]);

  //     // final sgbInvestDetails = results[0] as SGBinvestDetailsModel;
  //     // final sgbOrderDetails = results[1] as SGBorderDetialsModel;

  //     // emit(SGBinvestDataLoaded(
  //     //   sgbInvestDetailsModel: sgbInvestDetails,
  //     //   sgbOrderDetialsModel: sgbOrderDetails,
  //     // ));

  //     // emit(SgbFetchDataLoaded(
  //     //     sgbMasterDetailsModel: sgbInvestDetails,
  //     //     sgbOrderDetialsModel: sgbOrderDetails));
  //   } on SocketException catch (_) {
  //     emit(SGBinvestDataFailure());
  //   } catch (_) {
  //     emit(SGBinvestDataFailure());
  //   }
  //   try {
  //     // final sgbInvestDetails =
  //     //     await getSGBinvestDatailsUseCase.getSGBinvestDetailsUseCase();
  //     final sgbOrderDetails =
  //         await getSGBorderDatailsUseCase.getSGBorderDetailsUseCase();

  //     emit(SGBorderDataLoaded(
  //         sgbInvestDetailsModel:
  //             (state as SGBinvestDataLoaded).sgbInvestDetailsModel,
  //         sgbOrderDetialsModel: sgbOrderDetails));
  //     print("222222222");
  //     print(sgbOrderDetails.status);
  //   } on SocketException catch (_) {
  //     print('SGB socket exception');
  //     emit(SGBorderDataFailure());
  //   } catch (e) {
  //     print('SGB catch exception' + e.toString());
  //     emit(SGBorderDataFailure());
  //   }
  // }


  //  // Measure response time for sgbInvestDetails
  //     final investStartTime = DateTime.now();
  //     final investFuture = getSGBinvestDatailsUseCase.getSGBinvestDetailsUseCase();
      
  //     // Measure response time for sgbOrderDetails
  //     final orderStartTime = DateTime.now();
  //     final orderFuture = getSGBorderDatailsUseCase.getSGBorderDetailsUseCase();
      
  //     // Wait for both futures to complete
  //     final results = await Future.wait([investFuture, orderFuture]);
      
  //     // Calculate and log the response times
  //     final investDuration = DateTime.now().difference(investStartTime);
  //     final orderDuration = DateTime.now().difference(orderStartTime);
      
  //     print('SGB Invest Details Response Time: ${investDuration.inMilliseconds} ms');
  //     print('SGB Order Details Response Time: ${orderDuration.inMilliseconds} ms');
      
  //     final sgbInvestDetails = results[0] as SgbMasterDetailsModel;
  //     final sgbOrderDetails = results[1] as SgbOrderDetialsModel;

  //     emit(SgbFetchDataLoaded(
  //       sgbMasterDetailsModel: sgbInvestDetails,
  //       sgbOrderDetialsModel: sgbOrderDetails,
  //     ));
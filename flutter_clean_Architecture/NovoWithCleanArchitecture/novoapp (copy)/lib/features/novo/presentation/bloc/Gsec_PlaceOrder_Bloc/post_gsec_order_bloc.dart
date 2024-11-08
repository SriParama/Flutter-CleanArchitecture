import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novoapp/core/utils/global_const.dart';
import 'package:novoapp/features/novo/domine/entity/gsecPlaceOrderEntity.dart';
import 'package:novoapp/features/novo/domine/use_cases/gsec_useCases/delete_GsecPlaceorder_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/gsec_useCases/post_GsecPlaceorder_usecase.dart';

part 'post_gsec_order_event.dart';
part 'post_gsec_order_state.dart';

class GsecOrderBloc extends Bloc<PostGsecOrderEvent, GsecOrderState> {
  final PostGsecplaceOrderUseCase postGsecplaceOrderUseCase;
  final DeleteGsecplaceOrderUseCase deleteGsecplaceOrderUseCase;
  GsecOrderBloc(
      {required this.postGsecplaceOrderUseCase,
      required this.deleteGsecplaceOrderUseCase})
      : super(GsecOrderInitial()) {
    on<PostGsecOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  FutureOr<void> postGsecOrder(
    PostGsecOrderEvent event,
    Emitter<GsecOrderState> emit,
  ) async {
    emit(GsecOrderLoading());
    try {
      var res = await postGsecplaceOrderUseCase.call(GsecplaceOrderEntity(
        actionType: event.gsecplaceOrderEntity.actionType,
        amount: event.gsecplaceOrderEntity.amount,
        series: event.gsecplaceOrderEntity.series,
        masterId: event.gsecplaceOrderEntity.masterId,
        oldUnit: event.gsecplaceOrderEntity.oldUnit,
        orderNo: event.gsecplaceOrderEntity.orderNo,
        price: event.gsecplaceOrderEntity.price,
        unit: event.gsecplaceOrderEntity.unit,
        SIvalue: event.gsecplaceOrderEntity.SIvalue,
        SItext: event.gsecplaceOrderEntity.SItext,
      ));

      res.fold((failure) => emit(GsecOrderFailure(error: failure.message)),
          (response) {
        if (response['status'] == 'S') {
          emit(GsecOrderSuccess(message: response['orderStatus']));
        } else if (response['status'] == 'E') {
          emit(GsecOrderFailure(error: response['errMsg']));
        } else if (response['status'] == 'I') {
          emit(GsecOrderFailure(error: response['errMsg']));
        } else {
          print('failed......');
          emit(GsecOrderFailure(error: AppContsTexts.failed));
        }
      });
    } on SocketException catch (e) {
      print(e.toString());
      emit(GsecOrderFailure(error: AppContsTexts.socketExeption));
    } catch (e) {
      print(e.toString());
      emit(GsecOrderFailure(error: AppContsTexts.socketExeption));
    }
  }

  FutureOr<void> deleteGsecOrder(
    DeleteGsecOrderEvent event,
    Emitter<GsecOrderState> emit,
  ) async {
    emit(GsecOrderLoading());
    try {
      var res = await deleteGsecplaceOrderUseCase.call(GsecplaceOrderEntity(
        actionType: event.gsecplaceOrderEntity.actionType,
        amount: event.gsecplaceOrderEntity.amount,
        series: event.gsecplaceOrderEntity.series,
        masterId: event.gsecplaceOrderEntity.masterId,
        oldUnit: event.gsecplaceOrderEntity.oldUnit,
        orderNo: event.gsecplaceOrderEntity.orderNo,
        price: event.gsecplaceOrderEntity.price,
        unit: event.gsecplaceOrderEntity.unit,
        SIvalue: event.gsecplaceOrderEntity.SIvalue,
        SItext: event.gsecplaceOrderEntity.SItext,
      ));

      res.fold((failure) => emit(GsecOrderFailure(error: failure.message)),
          (response) {
        if (response['status'] == 'S') {
          emit(GsecOrderSuccess(message: response['orderStatus']));
        } else if (response['status'] == 'E') {
          emit(GsecOrderFailure(error: response['errMsg']));
        } else if (response['status'] == 'I') {
          emit(GsecOrderFailure(error: response['errMsg']));
        } else {
          print('failed......');
          emit(GsecOrderFailure(error: AppContsTexts.failed));
        }
      });
    } on SocketException catch (e) {
      print(e.toString());
      emit(GsecOrderFailure(error: AppContsTexts.socketExeption));
    } catch (e) {
      print(e.toString());
      emit(GsecOrderFailure(error: AppContsTexts.socketExeption));
    }
  }
}

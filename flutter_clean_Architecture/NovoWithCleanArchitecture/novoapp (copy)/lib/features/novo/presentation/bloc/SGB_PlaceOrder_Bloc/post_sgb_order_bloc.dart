import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:novoapp/core/common/globleVariables.dart';
import 'package:novoapp/core/utils/global_const.dart';
import 'package:novoapp/features/novo/domine/entity/sgbPlaceOrderEntity.dart';
import 'package:novoapp/features/novo/domine/use_cases/sgb_UseCases/delete_SgbPlaceorder_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/sgb_UseCases/post_SgbPlaceorder_usecase.dart';

part 'post_sgb_order_event.dart';
part 'post_sgb_order_state.dart';

class SgbOrderBloc extends Bloc<SgbOrderEvent, SgbOrderState> {
  final PostSGBplaceOrderUseCase postSGBplaceOrderUseCase;
  final DeleteSGBplaceOrderUseCase deleteSGBplaceOrderUseCase;
  SgbOrderBloc(
      {required this.postSGBplaceOrderUseCase,
      required this.deleteSGBplaceOrderUseCase})
      : super(SgbOrderInitial()) {
    on<PostSgbOrderEvent>(postSgbOrder);
    on<DeleteSgbOrderEvent>(deleteSgbOrder);
  }

  FutureOr<void> postSgbOrder(
    PostSgbOrderEvent event,
    Emitter<SgbOrderState> emit,
  ) async {
    emit(SgbOrderLoading());
    try {
      var res = await postSGBplaceOrderUseCase.call(SGBplaceOrderEntity(
        actionCode: event.sgBplaceOrderEntity.actionCode,
        amount: event.sgBplaceOrderEntity.amount,
        bidId: event.sgBplaceOrderEntity.bidId,
        masterId: event.sgBplaceOrderEntity.masterId,
        oldUnit: event.sgBplaceOrderEntity.oldUnit,
        orderNo: event.sgBplaceOrderEntity.orderNo,
        price: event.sgBplaceOrderEntity.price,
        unit: event.sgBplaceOrderEntity.unit,
        SIvalue: event.sgBplaceOrderEntity.SIvalue,
        SItext: event.sgBplaceOrderEntity.SItext,
      ));

      res.fold((failure) => emit(SgbOrderFailure(error: failure.message)),
          (response) {
        if (response['status'] == 'S') {
          emit(SgbOrderSuccess(message: response['orderStatus']));
        } else if (response['status'] == 'E') {
          emit(SgbOrderFailure(error: response['errMsg']));
        } else if (response['status'] == 'I') {
          emit(SgbOrderFailure(error: response['errMsg']));
        } else {
          print('failed......');
          emit(SgbOrderFailure(error: AppContsTexts.failed));
        }
      });
    } on SocketException catch (e) {
      print(e.toString());
      emit(SgbOrderFailure(error: AppContsTexts.socketExeption));
    } catch (e) {
      print(e.toString());
      emit(SgbOrderFailure(error: AppContsTexts.socketExeption));
    }
  }

  FutureOr<void> deleteSgbOrder(
    DeleteSgbOrderEvent event,
    Emitter<SgbOrderState> emit,
  ) async {
    emit(SgbOrderLoading());
    try {
      var res = await deleteSGBplaceOrderUseCase.call(SGBplaceOrderEntity(
        actionCode: event.sgBplaceOrderEntity.actionCode,
        amount: event.sgBplaceOrderEntity.amount,
        bidId: event.sgBplaceOrderEntity.bidId,
        masterId: event.sgBplaceOrderEntity.masterId,
        oldUnit: event.sgBplaceOrderEntity.oldUnit,
        orderNo: event.sgBplaceOrderEntity.orderNo,
        price: event.sgBplaceOrderEntity.price,
        unit: event.sgBplaceOrderEntity.unit,
        SIvalue: event.sgBplaceOrderEntity.SIvalue,
        SItext: event.sgBplaceOrderEntity.SItext,
      ));

      res.fold((failure) => emit(SgbOrderFailure(error: failure.message)),
          (response) {
        if (response['status'] == 'S') {
          emit(SgbOrderSuccess(message: response['orderStatus']));
        } else if (response['status'] == 'E') {
          emit(SgbOrderFailure(error: response['errMsg']));
        } else if (response['status'] == 'I') {
          emit(SgbOrderFailure(error: response['errMsg']));
        } else {
          print('failed......');
          emit(SgbOrderFailure(error: AppContsTexts.failed));
        }
      });
    } on SocketException catch (e) {
      print(e.toString());
      emit(SgbOrderFailure(error: AppContsTexts.socketExeption));
    } catch (e) {
      print(e.toString());
      emit(SgbOrderFailure(error: AppContsTexts.socketExeption));
    }
  }

  // @override
  // Stream<SgbOrderState> mapEventToState(SgbOrderEvent event) async* {
  //   if (event is PostSgbOrderEvent) {
  //     yield SgbOrderLoading();
  //     try {
  //       final response = await postSGBplaceOrderUseCase.postSGBplaceOrderUseCase(postBidDetails)

  //       if (response != null && response.isNotEmpty) {
  //         if (response['status'] == 'S') {
  //           yield SgbOrderSuccess(response['orderStatus']);
  //         } else {
  //           yield SgbOrderFailure(response['errMsg'] ?? somethingError);
  //         }
  //       } else {
  //         yield SgbOrderFailure('Failed to place order');
  //       }
  //     } catch (e) {
  //       yield SgbOrderFailure(e.toString());
  //     }
  //   } else if (event is DeleteSgbOrderEvent) {
  //     yield SgbOrderLoading();
  //     try {
  //       final response = await sgbPlaceOrderApi(
  //           context: event.context, postBidDetails: event.deleteDetails);

  //       if (response != null && response.isNotEmpty) {
  //         if (response['status'] == 'S') {
  //           yield SgbOrderSuccess(response['orderStatus']);
  //         } else {
  //           yield SgbOrderFailure(response['errMsg'] ?? somethingError);
  //         }
  //       } else {
  //         yield SgbOrderFailure('Failed to delete order');
  //       }
  //     } catch (e) {
  //       yield SgbOrderFailure(e.toString());
  //     }
  //   }
  // }
}

part of 'post_sgb_order_bloc.dart';

sealed class SgbOrderState extends Equatable {
  const SgbOrderState();

  @override
  List<Object> get props => [];
}

class SgbOrderInitial extends SgbOrderState {}

class SgbOrderLoading extends SgbOrderState {}

class SgbOrderSuccess extends SgbOrderState {
  final String message;

  SgbOrderSuccess({required this.message});
}

class SgbOrderFailure extends SgbOrderState {
  final String error;

  SgbOrderFailure({required this.error});
}

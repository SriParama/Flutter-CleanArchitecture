part of 'post_gsec_order_bloc.dart';

sealed class GsecOrderState extends Equatable {
  const GsecOrderState();

  @override
  List<Object> get props => [];
}

final class GsecOrderInitial extends GsecOrderState {}

class GsecOrderLoading extends GsecOrderState {}

class GsecOrderSuccess extends GsecOrderState {
  final String message;

  GsecOrderSuccess({required this.message});
}

class GsecOrderFailure extends GsecOrderState {
  final String error;

  GsecOrderFailure({required this.error});
}

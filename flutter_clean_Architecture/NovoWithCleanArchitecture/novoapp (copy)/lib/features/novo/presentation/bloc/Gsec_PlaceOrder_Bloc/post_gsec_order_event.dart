part of 'post_gsec_order_bloc.dart';

sealed class GsecOrderEvent extends Equatable {
  const GsecOrderEvent();

  @override
  List<Object> get props => [];
}

class PostGsecOrderEvent extends GsecOrderEvent {
  final GsecplaceOrderEntity gsecplaceOrderEntity;

  const PostGsecOrderEvent({required this.gsecplaceOrderEntity});
}

class DeleteGsecOrderEvent extends GsecOrderEvent {
  final GsecplaceOrderEntity gsecplaceOrderEntity;

  const DeleteGsecOrderEvent({required this.gsecplaceOrderEntity});
}

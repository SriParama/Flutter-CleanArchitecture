part of 'post_sgb_order_bloc.dart';

sealed class SgbOrderEvent extends Equatable {
  const SgbOrderEvent();

  @override
  List<Object> get props => [];
}

class PostSgbOrderEvent extends SgbOrderEvent {
  final SGBplaceOrderEntity sgBplaceOrderEntity;

  const PostSgbOrderEvent({required this.sgBplaceOrderEntity});
}

class DeleteSgbOrderEvent extends SgbOrderEvent {
  final SGBplaceOrderEntity sgBplaceOrderEntity;

  const DeleteSgbOrderEvent({required this.sgBplaceOrderEntity});
}

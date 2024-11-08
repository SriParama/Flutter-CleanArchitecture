import 'package:equatable/equatable.dart';

class SGBplaceOrderEntity extends Equatable {
  final String? actionCode;
  final int? amount;
  final String? bidId;
  final int? masterId;
  final int? oldUnit;
  final String? orderNo;
  final int? price;
  final int? unit;
  final bool? SIvalue;
  final String? SItext;

  // final BuildContext? context;

  const SGBplaceOrderEntity({
    this.actionCode,
    this.amount,
    this.bidId,
    this.masterId,
    this.oldUnit,
    this.orderNo,
    this.price,
    this.unit,
    this.SIvalue,
    this.SItext,

    // this.context,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        actionCode,
        amount,
        bidId,
        masterId,
        oldUnit,
        orderNo,
        price,
        unit,
        SIvalue,
        SItext
      ];
}

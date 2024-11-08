import 'package:equatable/equatable.dart';

class GsecplaceOrderEntity extends Equatable {
  final int? masterId;
  final int? unit;
  final int? oldUnit;
  final String? actionType;
  final int? price;
  final String? orderNo;
  final String? series;
  final double? amount;
  final String? SItext;
  final bool? SIvalue;

  // final BuildContext? context;

  const GsecplaceOrderEntity({
    this.masterId,
    this.unit,
    this.oldUnit,
    this.actionType,
    this.price,
    this.orderNo,
    this.series,
    this.amount,
    this.SItext,
    this.SIvalue,

    // this.context,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        masterId,
        unit,
        oldUnit,
        actionType,
        price,
        orderNo,
        series,
        amount,
        SItext,
        SIvalue,
      ];
}

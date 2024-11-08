import 'package:fpdart/fpdart.dart';
import 'package:novoapp/core/error/failure.dart';
import 'package:novoapp/features/auth/domine/enities/login_entity.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/gsecModel/gsecInvestModel.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/gsecModel/gsecorderdetails_model.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/novoModel/dashboard_model.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_InvestDetails_model.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_OrderDetails_model.dart';
import 'package:novoapp/features/novo/domine/entity/gsecPlaceOrderEntity.dart';
import 'package:novoapp/features/novo/domine/entity/sgbPlaceOrderEntity.dart';

abstract class NovoRepository {
  //DashBoard....
  Future<DashboardModel> getDashBoardDetails();
  Future<String> getClientId();
  Future<String> getClientName();
  //SGB....
  Future<SGBinvestDetailsModel> getSGBinvestDetails();
  Future<dynamic> getAccountBalanceDetails();
  Future<SGBorderDetialsModel> getSGBorderDetails();
  Future<Either<Failure, Map<String, dynamic>>> postSGBplaceOrder(
      SGBplaceOrderEntity postSgbBidDetails);
  Future<Either<Failure, Map<String, dynamic>>> deleteSGBplaceOrder(
      SGBplaceOrderEntity postSgbBidDetails);

  //Gsec...
  Future<GsecInvestDetailsModel> getGsecinvestDetails();
  Future<GsecOrderDetailsModel> getGsecorderDetails();
  Future<Either<Failure, Map<String, dynamic>>> postGsecplaceOrder(
      GsecplaceOrderEntity postSgbBidDetails);
  Future<Either<Failure, Map<String, dynamic>>> deleteGsecplaceOrder(
      GsecplaceOrderEntity postSgbBidDetails);
}

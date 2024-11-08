import 'package:novoapp/features/novo/data/novo_data_source/models/gsecModel/gsecInvestModel.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/gsecModel/gsecorderdetails_model.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_InvestDetails_model.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_OrderDetails_model.dart';
import 'package:novoapp/features/novo/domine/entity/gsecPlaceOrderEntity.dart';
import 'package:novoapp/features/novo/domine/entity/sgbPlaceOrderEntity.dart';

import 'models/novoModel/dashboard_model.dart';

abstract class NovoRemoteDataSource {
  Future<DashboardModel> getDashBoardDetails();
  Future<String> getClientId();
  Future<String> getClientName();
  Future<SGBinvestDetailsModel> getSGBinsvestDetails();
  Future<dynamic> getAccountBalanceDetails();
  Future<SGBorderDetialsModel> getSGBorderDetails();
  Future<Map<String, dynamic>> postSGBplaceOrder(
      SGBplaceOrderEntity postBidDetails);
  Future<Map<String, dynamic>> deleteSGBplaceOrder(
      SGBplaceOrderEntity postBidDetails);
  Future<GsecInvestDetailsModel> getGsecinvestDetails();
  Future<GsecOrderDetailsModel> getGsecorderDetails();
  Future<Map<String, dynamic>> postGsecplaceOrder(
      GsecplaceOrderEntity postBidDetails);
  Future<Map<String, dynamic>> deleteGsecplaceOrder(
      GsecplaceOrderEntity postBidDetails);
}

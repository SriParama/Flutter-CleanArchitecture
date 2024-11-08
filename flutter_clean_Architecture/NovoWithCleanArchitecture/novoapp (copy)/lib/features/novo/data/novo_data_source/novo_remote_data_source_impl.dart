import 'package:novoapp/features/novo/data/novo_data_source/API%20Call/Sgb_ApiCall.dart';
import 'package:novoapp/features/novo/data/novo_data_source/API%20Call/Gsec_Apicall.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/gsecModel/gsecInvestModel.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/gsecModel/gsecorderdetails_model.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_InvestDetails_model.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_OrderDetails_model.dart';
import 'package:novoapp/features/novo/domine/entity/gsecPlaceOrderEntity.dart';
import 'package:novoapp/features/novo/domine/entity/sgbPlaceOrderEntity.dart';

import 'API Call/Novo_Apicall.dart';
import 'models/novoModel/dashboard_model.dart';
import 'novo_remote_data_sources.dart';

class NovoRemoteDataSourceImpl implements NovoRemoteDataSource {
  @override
  Future<String> getClientId() async {
    try {
      //print("await getclientIdApi('tokenValidation')");
      //print(
      // "await getclientIdApi('tokenValidation')${await getclientIdApi('tokenValidation')}");
      return await getclientIdApi();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error fetching client ID+++++++++++++++: $e');
      throw Exception('Failed to fetch client ID');
    }
  }

  @override
  Future<String> getClientName() async {
    try {
      return await getClientNameApi();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error fetching client Name: $e');
      throw Exception('Failed to fetch client Name');
    }
  }

  @override
  Future<DashboardModel> getDashBoardDetails() async {
    try {
      return await getDashboardApi();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error fetching dashboard details: $e');
      throw Exception('Failed to fetch dashboard details');
    }
  }

  @override
  Future<SGBinvestDetailsModel> getSGBinsvestDetails() async {
    try {
      return await getSGBinvestDetailsApi();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error fetching dashboard details: $e');
      throw Exception('Failed to fetch getSbgMaster details');
    }
  }

  @override
  Future<dynamic> getAccountBalanceDetails() async {
    try {
      return await getAccountBalanceApi();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error fetching dashboard details: $e');
      throw Exception('Failed to fetch fund details');
    }
  }

  @override
  Future<SGBorderDetialsModel> getSGBorderDetails() async {
    try {
      return await getSGBorderDetailsApi();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error fetching dashboard details: $e');
      throw Exception('Failed to fetch sgbHistory details');
    }
  }

  @override
  Future<Map<String, dynamic>> postSGBplaceOrder(
      SGBplaceOrderEntity postBidDetails) async {
    try {
      return await postSGBplaceOrderApi(postBidDetails);
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error fetching dashboard details: $e');
      throw Exception('Failed to fetch sgbPlaceOrder details');
    }
  }

  @override
  Future<Map<String, dynamic>> deleteSGBplaceOrder(
      SGBplaceOrderEntity postBidDetails) async {
    try {
      return await postSGBplaceOrderApi(postBidDetails);
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error fetching dashboard details: $e');
      throw Exception('Failed to fetch sgbPlaceOrder details');
    }
  }

  @override
  Future<Map<String, dynamic>> deleteGsecplaceOrder(
      GsecplaceOrderEntity postBidDetails) async {
    try {
      return await postGsecplaceOrderApi(postBidDetails);
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error fetching dashboard details: $e');
      throw Exception('Failed to fetch postGsecDeleteorder details');
    }
  }

  @override
  Future<GsecInvestDetailsModel> getGsecinvestDetails() async {
    try {
      return await getGsecinvestDetailsApi();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error fetching dashboard details: $e');
      throw Exception('Failed to fetch getGsecInvest details');
    }
  }

  @override
  Future<GsecOrderDetailsModel> getGsecorderDetails() async {
    try {
      return await getGsecorderDetailsApi();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error fetching dashboard details: $e');
      throw Exception('Failed to fetch getGsecOrder details');
    }
  }

  @override
  Future<Map<String, dynamic>> postGsecplaceOrder(
      GsecplaceOrderEntity postBidDetails) async {
    try {
      return await postGsecplaceOrderApi(postBidDetails);
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error fetching dashboard details: $e');
      throw Exception('Failed to fetch postGsecPlaceorder details');
    }
  }
}

import 'dart:convert';

import 'package:novoapp/core/utils/end_point_address.dart';
import 'package:novoapp/features/novo/data/novo_data_source/API%20Call/Novo_Apicall.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_InvestDetails_model.dart';
import 'package:http/http.dart' as http;
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_OrderDetails_model.dart';
import 'package:novoapp/features/novo/domine/entity/sgbPlaceOrderEntity.dart';

Future<SGBinvestDetailsModel> getSGBinvestDetailsApi() async {
  try {
    http.Response? response = await getMethodApi(ApiEndPoint.getSgbMaster);

    if (response != null && response.statusCode == 200) {
      return SGBinvestDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      // Handle unsuccessful responses or null response
      throw Exception('Failed to load dashboard data');
    }
  } catch (e) {
    // Log the error or handle it as necessary
    //print('Error occurred while fetching dashboard data: $e');
    // Re-throw the exception to be handled by the caller, or return a default value
    throw Exception('Error fetching dashboard data');
  }
}

Future<dynamic> getAccountBalanceApi() async {
  try {
    http.Response? response = await getMethodApi(ApiEndPoint.fetchFund);

    if (response != null && response.statusCode == 200) {
      // return jsonDecode(response.body);
      Map json = jsonDecode(response.body);
      print(response.body);
      if (json["status"] == "S") {
        return json['accountBalance'] == '' ||
                json['accountBalance'] == null ||
                json['accountBalance'] == '-'
            ? 'NA'
            : json['accountBalance'] is String
                ? double.parse(json['accountBalance'].toString()).floor()
                : double.parse(json['accountBalance'].toString()).floor();
      } else {
        return "NA";
      }
    } else {
      // Handle unsuccessful responses or null response
      throw Exception('Failed to fetch fund data');
    }
  } catch (e) {
    // Log the error or handle it as necessary
    //print('Error occurred while fetching dashboard data: $e');
    // Re-throw the exception to be handled by the caller, or return a default value
    throw Exception('Error fetching dashboard data');
  }
}

Future<SGBorderDetialsModel> getSGBorderDetailsApi() async {
  try {
    http.Response? response = await getMethodApi(ApiEndPoint.getSgbHistory);

    if (response != null && response.statusCode == 200) {
      return SGBorderDetialsModel.fromJson(jsonDecode(response.body));
    } else {
      // Handle unsuccessful responses or null response
      throw Exception('Failed to load dashboard data');
    }
  } catch (e) {
    // Log the error or handle it as necessary
    //print('Error occurred while fetching dashboard data: $e');
    // Re-throw the exception to be handled by the caller, or return a default value
    throw Exception('Error fetching dashboard data');
  }
}

Future<Map<String, dynamic>> postSGBplaceOrderApi(
    SGBplaceOrderEntity postBidDetails) async {
  try {
    http.Response? response = await postSgbPlaceOrderMethodApi(
        ApiEndPoint.sgbplaceOrder, postBidDetails);
    print('sbgresponse');
    print(response);

    if (response != null && response.statusCode == 200) {
      print("response.bodysgbplacoreder");
      print(response.body);
      return jsonDecode(response.body);
    } else {
      // Handle unsuccessful responses or null response
      throw Exception('Failed to post SGB post Order data');
    }
  } catch (e) {
    // Log the error or handle it as necessary
    //print('Error occurred while fetching dashboard data: $e');
    // Re-throw the exception to be handled by the caller, or return a default value
    throw Exception('Error fetching SGB post Order  data');
  }
}

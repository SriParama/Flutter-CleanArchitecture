import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:novoapp/core/utils/end_point_address.dart';
import 'package:novoapp/features/novo/data/novo_data_source/API%20Call/Novo_Apicall.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/gsecModel/gsecInvestModel.dart';
import 'package:http/http.dart' as http;
import 'package:novoapp/features/novo/data/novo_data_source/models/gsecModel/gsecorderdetails_model.dart';
import 'package:novoapp/features/novo/domine/entity/gsecPlaceOrderEntity.dart';

Future<GsecInvestDetailsModel> getGsecinvestDetailsApi() async {
  try {
    http.Response? response = await getMethodApi(ApiEndPoint.getGsecInvest);
    // print(response);

    if (response != null && response.statusCode == 200) {
      print(response.body);
      return GsecInvestDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      // Handle unsuccessful responses or null response
      throw Exception('Failed to load Gsec invest data');
    }
  } catch (e) {
    // Log the error or handle it as necessary
    //print('Error occurred while fetching dashboard data: $e');
    // Re-throw the exception to be handled by the caller, or return a default value
    throw Exception('Error fetching Gsec invest  data');
  }
}

Future<GsecOrderDetailsModel> getGsecorderDetailsApi() async {
  try {
    http.Response? response = await getMethodApi(ApiEndPoint.getGsecOrder);

    if (response != null && response.statusCode == 200) {
      return GsecOrderDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      // Handle unsuccessful responses or null response
      throw Exception('Failed to load Gsec order data');
    }
  } catch (e) {
    // Log the error or handle it as necessary
    //print('Error occurred while fetching dashboard data: $e');
    // Re-throw the exception to be handled by the caller, or return a default value
    throw Exception('Error fetching Gsec order  data');
  }
}

Future<Map<String, dynamic>> postGsecplaceOrderApi(
    GsecplaceOrderEntity postBidDetails) async {
  try {
    http.Response? response = await postGsecPlaceOrderMethodApi(
        ApiEndPoint.gsecplaceOrder, postBidDetails);
    print('sbgresponse');
    print(response);

    if (response != null && response.statusCode == 200) {
      print("response.bodysgbplacoreder");
      print(response.body);
      return jsonDecode(response.body);
    } else {
      // Handle unsuccessful responses or null response
      throw Exception('Failed to post Gsec post Order data');
    }
  } catch (e) {
    // Log the error or handle it as necessary
    //print('Error occurred while fetching dashboard data: $e');
    // Re-throw the exception to be handled by the caller, or return a default value
    throw Exception('Error fetching Gsec post Order  data');
  }
}

// fetchNcbDetails() async {
//   try {
//     final response = await getMethod('getNcbMaster', context);
//     // ////////print('getNcbMaster');
//     // ////////print(response.body);

//     if (response != null && response.statusCode == 200) {
//       NcbMasterDetails jsonResponse = ncbMasterDetailsFromJson(response.body);

//       if (jsonResponse.status == "S") {
//         return jsonResponse;
//       } else if (response['status'] == 'E') {
//         showSnackbar(
//             context,
//             response['errmsg'] == null || response['errmsg'].toString().isEmpty
//                 ? somethingError
//                 : response['errmsg'],
//             Colors.red);
//       } else if (response['status'] == 'I') {
//         showSnackbar(context, sessionError, Colors.red);
//         ChangeIndex().value = 0;
//         Navigator.pushNamedAndRemoveUntil(
//           context,
//           route.logIn,
//           (route) => false,
//         );
//         deleteCookieInSref(context);
//       } else {
//         showSnackbar(context, somethingError, Colors.red);
//       }
//     } else if (response == null || response.statusCode != 200) {
//       throw Exception('Failed to load SGB details');
//     }
//   } on ClientException catch (e) {
//     showSnackbar(context, "FSD01$somethingError", Colors.red);
//   } catch (e) {
//     ////////print('Catch Error in Sgbmaster');
//     ////////print(e.toString());
//     // showSnackbar(context, e.toString(), Colors.red);
//   }
//   ////////print('NULl');
//   return null;
// }

// fetchNcbHistory({required BuildContext context}) async {
//   //
//   try {
//     final response = await getMethod('getNcbOrderHistory', context);
//     // ////////print('*******');
//     // ////////print(response.body);

//     if (response != null && response.statusCode == 200) {
//       NcbHistoryModel jsonResponse = ncbHistoryModelFromJson(response.body);
//       if (jsonResponse.status == "S") {
//         return jsonResponse;
//       } else if (response['status'] == 'E') {
//         showSnackbar(
//             context,
//             response['errmsg'] == null || response['errmsg'].toString().isEmpty
//                 ? somethingError
//                 : response['errmsg'],
//             Colors.red);
//       } else if (response['status'] == 'I') {
//         showSnackbar(context, sessionError, Colors.red);
//         ChangeIndex().value = 0;
//         Navigator.pushNamedAndRemoveUntil(
//           context,
//           route.logIn,
//           (route) => false,
//         );
//         deleteCookieInSref(context);
//       } else {
//         showSnackbar(context, somethingError, Colors.red);
//       }
//     } else if (response == null || response.statusCode != 200) {
//       throw Exception('Failed to load NCB History details');
//     }
//   } on ClientException catch (e) {
//     showSnackbar(context, "FSH01$somethingError", Colors.red);
//   } catch (e) {
//     ////////print(e.toString());

//     // showSnackbar(context, e.toString(), Colors.red);
//   }

//   return null;
// }

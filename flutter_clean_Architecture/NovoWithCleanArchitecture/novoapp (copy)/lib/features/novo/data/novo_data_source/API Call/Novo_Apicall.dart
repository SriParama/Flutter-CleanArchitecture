// import 'dart:convert';

import 'dart:convert';

import 'package:novoapp/core/utils/end_point_address.dart';
import 'package:novoapp/features/novo/domine/entity/gsecPlaceOrderEntity.dart';
import 'package:novoapp/features/novo/domine/entity/sgbPlaceOrderEntity.dart';
import '../models/novoModel/dashboard_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//Get the Data From the Get Method API...

Future<http.Response?> getMethodApi(String url) async {
  try {
    SharedPreferences sref = await SharedPreferences.getInstance();
    String cookies = sref.getString("cookies") ?? "";
    //print(cookies);
    http.Response response = await http.get(
      Uri.parse("${ApiAddress.mainApiAddress}$url"),
      headers: {
        "cookie": cookies,
        'User-Agent': 'YourApp/1.0 (APP)',
        ...ApiAddress.mainApiHeaders,
      },
    );

    return response;
  } catch (e) {
    // Handle the error, such as logging it or displaying a message to the user
    //print('Error occurred: $e');
    // You could return a default response or `null`
    return null;
  }
}

//Post the Data From the Post Method API...

Future<http.Response?> postSgbPlaceOrderMethodApi(
  String url,
  SGBplaceOrderEntity data,
) async {
  try {
    SharedPreferences sref = await SharedPreferences.getInstance();
    String cookies = sref.getString("cookies") ?? "";
    //print(cookies);
    http.Response response = await http.post(
      Uri.parse("${ApiAddress.mainApiAddress}$url"),
      body: jsonEncode({
        "actionCode": data.actionCode, // (ActionCodes : "N","M","C")
        "amount": data.amount,
        "bidId": data.bidId, // (*Compulsory for modify & cancel)
        "masterId": data.masterId,
        "oldUnit": data.oldUnit, // (*Compulsory for modify & cancel)
        "orderNo": data
            .orderNo, // (*Generate random number for "NEW" and Compulsory return the Actual orderNo for modify & cancel)
        "price": data.price,
        "unit": data.unit,
        "SIvalue": data.SIvalue,
        "SItext": data.SItext
      }),
      headers: {
        "cookie": cookies,
        'User-Agent': 'YourApp/1.0 (APP)',
        ...ApiAddress.mainApiHeaders,
      },
    );

    return response;
  } catch (e) {
    // Handle the error, such as logging it or displaying a message to the user
    //print('Error occurred: $e');
    // You could return a default response or `null`
    return null;
  }
}

//Gsec Post PlaceOrder Details

Future<http.Response?> postGsecPlaceOrderMethodApi(
  String url,
  GsecplaceOrderEntity data,
) async {
  try {
    SharedPreferences sref = await SharedPreferences.getInstance();
    String cookies = sref.getString("cookies") ?? "";
    //print(cookies);
    http.Response response = await http.post(
      Uri.parse("${ApiAddress.mainApiAddress}$url"),
      body: jsonEncode({
        "masterId": data.masterId,
        "unit": data.unit,
        "oldUnit": data.actionType,
        "actionType": data.actionType,
        "price": data.price,
        "orderNo": data.orderNo,
        "series": data.series,
        "amount": data.amount,
        "SItext": data.SItext,
        "SIvalue": data.SIvalue,
      }),
      headers: {
        "cookie": cookies,
        'User-Agent': 'YourApp/1.0 (APP)',
        ...ApiAddress.mainApiHeaders,
      },
    );

    return response;
  } catch (e) {
    // Handle the error, such as logging it or displaying a message to the user
    //print('Error occurred: $e');
    // You could return a default response or `null`
    return null;
  }
}

Future<DashboardModel> getDashboardApi() async {
  try {
    http.Response? response = await getMethodApi(ApiEndPoint.dashboard);

    if (response != null && response.statusCode == 200) {
      return DashboardModel.fromJson(jsonDecode(response.body));
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

Future<String> getclientIdApi() async {
  try {
    http.Response? response = await getMethodApi(ApiEndPoint.tokenValidation);
    //print("clientID");
    // //print(response!.body);

    if (response != null && response.statusCode == 200) {
      //print('respnse is not empty');
      Map json = jsonDecode(response.body);
      if (json['status'] == 'S') {
        //print('response ${json['clientId']}');
        return json['clientId'];
      } else {
        return '';
      }
    } else {
      // Handle unsuccessful responses or null response
      //print('+++++++++++++++');
      throw Exception('Failed to load ClientId data');
    }
  } catch (e) {
    //print('=====================');
    // Log the error or handle it as necessary
    //print('Error occurred while fetching ClientId data: $e');
    // Re-throw the exception to be handled by the caller, or return a default value
    throw Exception('Error fetching ClientId data');
  }
}

Future<String> getClientNameApi() async {
  try {
    http.Response? response = await getMethodApi(ApiEndPoint.getClientName);
    //print(response!.body);

    if (response != null && response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['status'] == 'S') {
        //print('clientName');
        //print('${json['clientName']}');
        return json['clientName'];
      } else {
        return '';
      }
    } else {
      // Handle unsuccessful responses or null response
      throw Exception('Failed to load ClientId data');
    }
  } catch (e) {
    // Log the error or handle it as necessary
    //print('Error occurred while fetching ClientId data: $e');
    // Re-throw the exception to be handled by the caller, or return a default value
    throw Exception('Error fetching ClientId data');
  }
}

// getClientName(context) async {
//   try {
//     var response = await getCookieApi("getClientName");
//     if (response != null && response.statusCode == 200) {
//       Map json = jsonDecode(response.body);
//       if (json["status"] == "S") {
//         return json["clientName"];
//       }
//     }
//   } catch (e) {
//     showSnackbar(context,
//         e.toString().isNotEmpty ? e.toString() : somethingError, Colors.red);
//   }
//   return null;
// }

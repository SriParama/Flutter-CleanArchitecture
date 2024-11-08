import 'dart:io';

import 'package:flattrade/core/utils/text_contants.dart';

class CommonMethods {
  static Future<String?> getLocalIpAddress() async {
    try {
      final List<NetworkInterface> interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.IPv4,
      );
      for (var interface in interfaces) {
        for (var address in interface.addresses) {
          if (!address.isLoopback) {
            
           return address.address;
          }
        }
      }
    } catch (e) {
      throw Exception(APPTextConstants.invaludData);
    }
    return null;
  }

  static String getDeviceType([double screenSize = double.infinity]) {
    if (Platform.isAndroid) {
      return 'Andriod';
    } else if (Platform.isIOS) {
      return 'IOS';
    } else if (Platform.isWindows) {
      return 'Windows';
    } else if (Platform.isLinux) {
      return 'Linux';
    } else if (Platform.isMacOS) {
      return 'macOS';
    } else {
      return screenSize! > 600 ? 'Tab' : 'Mobile';
    }
  }
}

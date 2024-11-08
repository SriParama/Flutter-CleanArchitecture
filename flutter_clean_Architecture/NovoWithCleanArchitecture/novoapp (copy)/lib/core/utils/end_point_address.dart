class ApiAddress {
  // static const String socketAddress = 'wss://pitest.flattrade.in/NSCRIPTWSTp/';
  //Live
  // static const String mainApiAddress = 'https://novoapi.flattrade.in/';
  // static const Map<String, String> mainApiHeaders = {
  //   'Origin': 'https://novo.flattrade.in',
  //   'Referer': 'https://novo.flattrade.in'
  // };
  // static const String authMainApiAddress = 'https://authapi.flattrade.in/';
  // static const Map<String, String> authMainApiHeaders = {
  //   'Origin': 'https://auth.flattrade.in',
  //   'Referer': 'https://auth.flattrade.in'
  // };
  //Local
  static const String mainApiAddress = 'http://192.168.02.137:29092/';
  static const Map<String, String> mainApiHeaders = {
    'Origin': 'http://localhost:8080',
    'Referer': 'http://localhost:8080'
  };
  static const String authMainApiAddress = 'https://authapi.flattrade.in/';
  static const Map<String, String> authMainApiHeaders = {
    'Origin': 'https://auth.flattrade.in',
    'Referer': 'https://auth.flattrade.in'
  };
}

class ApiEndPoint {
  static const String webAuthlogin = 'webAuthlogin';
  static const String ftauthreset = 'ftauthreset';
  static const String sendOTP = 'sendOTP';
  static const String session = 'auth/session';
  static const String tokenValidation = 'tokenValidation';
  static const String getClientName = 'getClientName';
  static const String dashboard = 'dashboard';
  static const String getSgbMaster = 'getSgbMaster';
  static const String getSgbHistory = 'sgb/getSgbHistory';
  static const String sgbplaceOrder = 'sgb/placeOrder';
  static const String fetchFund = 'sgb/fetchFund';

  static const String getGsecInvest = 'getNcbMaster';
  static const String getGsecOrder = 'getNcbOrderHistory';
  static const String gsecplaceOrder = 'ncb/ncbPlaceOrder';
}

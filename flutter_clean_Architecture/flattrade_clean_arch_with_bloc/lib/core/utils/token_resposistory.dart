
import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {
  static const String tokenKey = 'token';
  static const String userid = "userid";

  Future<void> saveToken(String token, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
    await prefs.setString(userid, userId);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  Future<String?> getUSerid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userid);
  }

  Future<void> clearUseridToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(userid);
  }

}

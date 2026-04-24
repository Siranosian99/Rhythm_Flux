import 'package:shared_preferences/shared_preferences.dart';

class TokenHelper {

  Future<void> tokenLocalSaver(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("accsesToken is Saved:$token}");
    await prefs.setString('token', token);
  }

  Future<String?> tokenLocalGetter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('token');
    return action;
  }
  Future<void> refreshTokenLocalSaver(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("refreshToken is Saved:$token}");
    await prefs.setString('refreshToken', token);
  }

  Future<String?> refreshTokenLocalGetter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('refreshToken');
    return action;
  }

  Future<bool?> refreshTokenLocalRemover() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final  action = prefs.remove('refreshToken');
    return action;
  }
  Future<void> userIdLocalSaver(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  Future<String?> userIdLocalGetter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('userId');
    return action;
  }

}
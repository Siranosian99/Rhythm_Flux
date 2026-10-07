import 'package:shared_preferences/shared_preferences.dart';

class TokenHelper {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  Future<void> tokenLocalSaver(String token) async {
    print("accsesToken is Saved:$token}");
    await _prefs.setString('token', token);
  }

  String? tokenLocalGetter()  {
    return _prefs.getString('token');
  }
  Future<bool?> tokenLocalRemover() async {
    return _prefs.remove('token');
  }
  Future<void> refreshTokenLocalSaver(String token) async {
    print("refreshToken is Saved:$token}");
    await _prefs.setString('refreshToken', token);
  }

  String? refreshTokenLocalGetter()  {
    return _prefs.getString('refreshToken');;
  }

  Future<bool?> refreshTokenLocalRemover() async {
    final  action = _prefs.remove('refreshToken');
    return action;
  }
  Future<void> userIdLocalSaver(String userId) async {
    await _prefs.setString('userId', userId);
  }

 String? userIdLocalGetter()  {
    return  _prefs.getString('userId');
  }

}
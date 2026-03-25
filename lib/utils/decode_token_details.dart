import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DecoderUtils {
  static bool decoder(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    print("-_-_-_-:$decodedToken");
    return decodedToken["isVerified"];
  }

  static Future<bool> isVerifySaver(bool isVerify) async {
    final prefs = await SharedPreferences.getInstance();
    bool isVerified = await prefs.setBool('isVerified', isVerify);
    return isVerified;
  }

  static Future<bool> isVerifiedToken() async {
    final prefs = await SharedPreferences.getInstance();
    bool isVerified = prefs.getBool('isVerified') ?? false;
    return isVerified;
  }
  static void removeKey()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isVerified');

  }
}

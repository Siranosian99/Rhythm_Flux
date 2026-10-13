
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DecoderUtils {
  static late final SharedPreferences _prefs;
  static bool _isInitialized = false;

  static Future<void> init() async {
    if (_isInitialized) return;

    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  static bool decoder(String token) {
    try {
      final decodedToken = JwtDecoder.decode(token);
      return decodedToken['isVerified'] == true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> isVerifySaver(bool isVerify) {
    return _prefs.setBool('isVerified', isVerify);
  }

  static bool isVerifiedToken() {
    return _prefs.getBool('isVerified') ?? false;
  }

  static Future<void> removeKey() async {
    await _prefs.remove('isVerified');
  }
}

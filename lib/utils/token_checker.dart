import 'package:jwt_decode/jwt_decode.dart';

bool isTokenExpired(String token) {
  try {
    return Jwt.isExpired(token);
  } catch (e) {
    return true;
  }
}
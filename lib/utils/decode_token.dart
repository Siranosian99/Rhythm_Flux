import 'package:jwt_decoder/jwt_decoder.dart';

class DecoderUtils{
static bool decoder(String token){
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  return decodedToken["isVerified"];
  print("YOUR DECODED TOKEN:$decodedToken");
}}
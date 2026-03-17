import 'package:dio/dio.dart';
import 'package:rhythm_flux/utils/decode_token_details.dart';
import 'package:rhythm_flux/utils/token_helper.dart';

class UserService{
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:3000",
      headers: {"Content-Type": "application/json"},
    ),
  );
  final _tokenHelper=TokenHelper();

  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/userAuth/create',
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 201) {
        print("user Created Brooo:${response.data}");
        print(response.data);
      }
    } on DioException catch (e) {

      if (e.response != null) {
        print("Backend error: ${e.response!.data}");
      } else {
        print("Connection error:  ${e.message}");
      }
    }
  }
  Future<bool?> login({required String email, required String password}) async {
    try {
      final response = await _dio.post(
        '/userAuth/login',
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        DecoderUtils.decoder(response.data['accessToken']);
        DecoderUtils.tokenSaver(DecoderUtils.decoder(response.data['accessToken']));
        _tokenHelper.tokenLocalSaver(response.data['accessToken']);
        _tokenHelper.refreshTokenLocalSaver(response.data['user']['refreshToken']);
        print(response.data);
        // if (!response.data['user']["isVerified"])
        //   print("verify Email");
        //
        //   // ScaffoldMessenger.of(context).showSnackBar(
        //   //     SnackBar(content: Text("Please verify your email first!"))
        //   // );
        // }

        // final verifyToken= response.data['verifyToken'];
        // await _dio.post('/userAuth/verify',
        // data: {
        //   "verifyToken":verifyToken
        // });

        // final token = response.data['accessToken'];
        // final rtoken = response.data['refreshToken'];

        // _tokenHelper.tokenLocalSaver(token);
        // _tokenHelper.refreshTokenLocalSaver(rtoken);
        print("login succes");
        return true;
      }
    } on DioException catch (e) {
      print(e.response?.data);
    }
    return null;
  }

  Future<bool?> refreshToken() async {
    try {
      final rtoken = await _tokenHelper.refreshTokenLocalGetter();
      if (rtoken == null) return false;

      final response = await _dio.post(
        '/userAuth/refresh',
        data: {"refreshToken": rtoken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['accessToken'];
        _tokenHelper.tokenLocalSaver(newAccessToken);
        return true;
      }
    } on DioException catch (e) {
      print(e.response?.data);
    }
    return null;
  }

}
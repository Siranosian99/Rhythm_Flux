import 'package:dio/dio.dart';
import 'package:rhythm_flux/utils/token_helper.dart';

import '../../core/constant/api_config.dart';
import '../../utils/decode_token_details.dart';

class AuthRepository {
   final Dio dio;
   final TokenHelper tokenHelper;
  AuthRepository({required this.dio,required this.tokenHelper});

  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiConfig.createAccount,
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 201) {
        print("User Created :${response.data}");
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
      final response = await dio.post(
        ApiConfig.login,
        data: {"email": email, "password": password},
      );
      DecoderUtils.init();
      if (response.statusCode == 200) {
        // final VerifiedValue= DecoderUtils.decoder(response.data['user']['accessToken']);
        final isVerify = DecoderUtils.decoder(response.data['accessToken']);
        await DecoderUtils.isVerifySaver(isVerify);
        tokenHelper.tokenLocalSaver(response.data['accessToken']);
        tokenHelper.refreshTokenLocalSaver(
          response.data['user']['refreshToken'],
        );
        tokenHelper.userIdLocalSaver(response.data['user']['_id']);

        return true;
      }
    } on DioException catch (e) {
      throw Exception("error in login:$e");
    }
    return null;
  }
  Future<bool> refreshAccessToken() async {
    try {
      final refreshToken = tokenHelper.refreshTokenLocalGetter();

      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      final response = await dio.post(
        ApiConfig.refreshToken,
        data: {"refreshToken": refreshToken},
      );

      if (response.statusCode != 200) {
        return false;
      }

      final newAccessToken = response.data['accessToken'];

      if (newAccessToken == null || newAccessToken.isEmpty) {
        return false;
      }

      await tokenHelper.tokenLocalSaver(newAccessToken);

      return true;
    } on DioException catch (e) {
      print("REFRESH ERROR: ${e.response?.data}");
      return false;
    } catch (e) {
      print("UNKNOWN ERROR: $e");
      return false;
    }
  }
}
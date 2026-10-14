import 'package:dio/dio.dart';

import '../../core/constant/api_config.dart';
import '../../utils/decode_token_details.dart';

class AuthService {
  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
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
      final response = await _dio.post(
        ApiConfig.login,
        data: {"email": email, "password": password},
      );
      DecoderUtils.init();
      if (response.statusCode == 200) {
        // final VerifiedValue= DecoderUtils.decoder(response.data['user']['accessToken']);
        final isVerify = DecoderUtils.decoder(response.data['accessToken']);
        await DecoderUtils.isVerifySaver(isVerify);
        _tokenHelper.tokenLocalSaver(response.data['accessToken']);
        _tokenHelper.refreshTokenLocalSaver(
          response.data['user']['refreshToken'],
        );
        _tokenHelper.userIdLocalSaver(response.data['user']['_id']);

        return true;
      }
    } on DioException catch (e) {
      print(e.response?.data);
    }
    return null;
  }
  Future<bool> refreshAccessToken() async {
    try {
      final refreshToken = _tokenHelper.refreshTokenLocalGetter();

      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      final response = await _dio.post(
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

      await _tokenHelper.tokenLocalSaver(newAccessToken);

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
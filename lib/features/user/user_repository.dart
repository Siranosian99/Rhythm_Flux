import 'package:dio/dio.dart';

import '../../core/constant/api_config.dart';
import '../../utils/decode_token_details.dart';

class UserService {
  Future<void> getUser() async {
    try {
      await _tokenHelper.init();
      final token = _tokenHelper.tokenLocalGetter();
      final response = await _dio.get(
        ApiConfig.getUser,
        data: {"accessToken": token},
      );
      if (response.statusCode == 200) {
        // DecoderUtils.decoder(response.data['user']['accessToken']);
        final VerifiedValue = DecoderUtils.decoder(
          response.data['user']['accessToken'],
        );

        await DecoderUtils.isVerifySaver(VerifiedValue);
        final isVerified = await DecoderUtils.isVerifiedToken();
      }
    } on DioException catch (e) {
      print(e.response?.data);
    }
  }
}
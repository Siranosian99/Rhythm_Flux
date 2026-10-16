import 'package:dio/dio.dart';
import 'package:rhythm_flux/utils/token_helper.dart';

import '../../core/constant/api_config.dart';
import '../../utils/decode_token_details.dart';

class UserRepository {
   final Dio dio;
   final TokenHelper tokenHelper;
  UserRepository({required this.dio,required this.tokenHelper});

  Future<void> getUser() async {
    try {
      await tokenHelper.init();
      final token = tokenHelper.tokenLocalGetter();
      final response = await dio.get(
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

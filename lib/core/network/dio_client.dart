import 'package:dio/dio.dart';
import 'package:rhythm_flux/core/network/auth_interceptor.dart';
import 'package:rhythm_flux/utils/token_helper.dart';

import '../constant/api_config.dart';

class DioClient {
  late final Dio dio;
 late final TokenHelper tokenHelper;
  DioClient() {
    tokenHelper=TokenHelper();
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    // final AuthInterceptor interceptor=AuthInterceptor(dio: dio, tokenHelper: tokenHelper, refreshAccessToken: refreshAccessToken);
    // dio.interceptors.add(interceptor);
  }
  void addAuthInterceptor({
    required Future<bool> Function() refreshAccessToken,
  }) {
    dio.interceptors.add(
      AuthInterceptor(
        dio: dio,
        tokenHelper: tokenHelper,
        refreshAccessToken: refreshAccessToken,
      ),
    );
  }

}

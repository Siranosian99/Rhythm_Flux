import 'package:dio/dio.dart';
import 'package:rhythm_flux/core/network/auth_interceptor.dart';

import '../constant/api_config.dart';

class DioClient {
  late final Dio dio;

  DioClient({required AuthInterceptor authInterceptor}) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(authInterceptor);
  }
}

import 'package:dio/dio.dart';
import 'package:rhythm_flux/utils/token_helper.dart';

class AuthInterceptor extends Interceptor {
  final TokenHelper tokenHelper;
  final Future<bool> Function() refreshAccessToken;

  AuthInterceptor({
    required this.tokenHelper,
    required this.refreshAccessToken,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = tokenHelper.tokenLocalGetter();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      handler.next(options);
    } catch (error) {
      handler.reject(DioException(requestOptions: options, error: error));
    }
  }
}

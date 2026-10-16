import 'package:dio/dio.dart';
import 'package:rhythm_flux/utils/token_helper.dart';

import '../../utils/token_checker.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final TokenHelper tokenHelper;
  final Future<bool> Function() refreshAccessToken;

  AuthInterceptor({
    required this.dio,
    required this.tokenHelper,
    required this.refreshAccessToken,
  });

  Future<void> tokenRemover() async {
    await tokenHelper.refreshTokenLocalRemover();
    await tokenHelper.tokenLocalRemover();
  }

  bool isRefreshRequest(DioException err) {
    return err.requestOptions.path.contains("refresh");
  }

  bool isUnauthorized(DioException err) {
    return err.response?.statusCode == 401;
  }

  bool notTryAgain401(DioException err) {
    return err.requestOptions.extra['auth_retry'] == true;
  }

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

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (isRefreshRequest(err) || !isUnauthorized(err)) {
      handler.next(err);
      return;
    }
    if (notTryAgain401(err)) {
      await tokenRemover();
      handler.next(err);
      return;
    }
    await handleUnauthorized(err, handler);
  }

  Future<void> handleUnauthorized(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final token = tokenHelper.tokenLocalGetter();

      if (token == null || token.isEmpty) {
        await tokenRemover();
        print("------------- pre 1 latest removers");
        return handler.next(err);
      }
      print("is Token Expired:${isTokenExpired(token)}");
      final isExpired = isTokenExpired(token);
      final newToken = tokenHelper.tokenLocalGetter();
      if (!isExpired) {
        await tokenRemover();
        handler.next(err);
        return;
      }
      if (isExpired) {
        await refreshAndRetry(err, handler);
        return;
      }
      if (newToken == null || newToken.isEmpty) {
        await tokenRemover();
        handler.next(err);
        return;
      }
      await refreshAndRetry(err, handler);
    } catch (_) {
      handler.next(err);
    }
  }

  Future<void> refreshAndRetry(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final success = await refreshAccessToken().timeout(Duration(seconds: 2));

      if (!success) {
        await tokenRemover();
        handler.next(err);
        return;
      }
      final newToken = tokenHelper.tokenLocalGetter();

      if (newToken == null || newToken.isEmpty) {
        await tokenRemover();
        handler.next(err);
        return;
      }
      final request = err.requestOptions;

      request.extra['auth_retry'] = true;
      request.headers['Authorization'] = 'Bearer $newToken';

      final retryResponse = await dio.fetch(request);
      handler.resolve(retryResponse);
    } on DioException {
      handler.next(err);
    } on Exception {
      handler.next(err);
    }
  }
}

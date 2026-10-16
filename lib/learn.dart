import 'package:dio/dio.dart';
import 'package:rhythm_flux/utils/token_helper.dart';
import '../../utils/token_checker.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final TokenHelper tokenHelper;
  final Future<bool> Function() refreshAccessToken;
// @override
  // Future<void> onRequest(
  //   RequestOptions options,
  //   RequestInterceptorHandler handler,
  // ) async {
  //   try {
  //     await tokenHelper.init();
  //
  //     final token = tokenHelper.tokenLocalGetter();
  //
  //     if (token != null && token.isNotEmpty) {
  //       options.headers['Authorization'] = 'Bearer $token';
  //     }
  //
  //     handler.next(options);
  //   } catch (error) {
  //     handler.reject(
  //       DioException(
  //         requestOptions: options,
  //         error: error,
  //       ),
  //     );
  //   }
  // }
  AuthInterceptor({
    required this.dio,
    required this.tokenHelper,
    required this.refreshAccessToken,
  });

  // Access ve refresh token'ı temizler.
  Future<void> tokenRemover() async {
    await tokenHelper.refreshTokenLocalRemover();
    await tokenHelper.tokenLocalRemover();
  }

  // Request refresh endpoint'ine mi gidiyor?
  bool isRefreshRequest(DioException err) {
    return err.requestOptions.path.contains('refresh');
  }

  // Hata 401 mi?
  bool isUnauthorized(DioException err) {
    return err.response?.statusCode == 401;
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

    // Aynı request ikinci kez 401 alırsa yeniden refresh deneme.
    if (err.requestOptions.extra['auth_retry'] == true) {
      await tokenRemover();
      handler.next(err);
      return;
    }

    await handleUnauthorized(err, handler);
  }

  // 401 hatasının token kaynaklı olup olmadığını kontrol eder.
  Future<void> handleUnauthorized(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      await tokenHelper.init();

      final token = tokenHelper.tokenLocalGetter();

      if (token == null || token.isEmpty) {
        await tokenRemover();
        handler.next(err);
        return;
      }

      final isExpired = isTokenExpired(token);

      if (!isExpired) {
        // Token süresi dolmamış ama sunucu 401 döndürmüş.
        await tokenRemover();
        handler.next(err);
        return;
      }

      await refreshAndRetry(err, handler);
    } catch (_) {
      // Beklenmeyen bir hata varsa orijinal hatayı devam ettir.
      handler.next(err);
    }
  }

  // Token'ı yeniler ve başarılırsa önceki request'i tekrar gönderir.
  Future<void> refreshAndRetry(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final success = await refreshAccessToken().timeout(
        const Duration(seconds: 2),
      );

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

      // Bu request'in daha önce retry edildiğini işaretle.
      request.extra['auth_retry'] = true;
      request.headers['Authorization'] = 'Bearer $newToken';

      final retryResponse = await dio.fetch(request);

      handler.resolve(retryResponse);
    } on DioException {
      // Retry başarısızsa orijinal hatayı devam ettir.
      handler.next(err);
    } on Exception {
      // Timeout gibi diğer exception'larda da orijinal hatayı devam ettir.
      handler.next(err);
    }
  }
}
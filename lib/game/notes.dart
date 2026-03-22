import 'package:dio/dio.dart';
import 'package:rhythm_flux/utils/token_helper.dart';

class ApiService {
  final Dio _dio = Dio();
  final TokenHelper _tokenHelper = TokenHelper();

  ApiService() {
    _dio.options.baseUrl = "http://YOUR_API_URL";

    _dio.interceptors.add(
      InterceptorsWrapper(

        // 🔹 REQUEST
        onRequest: (options, handler) async {
          final token = await _tokenHelper.tokenLocalGetter();

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        // 🔹 ERROR
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {

            print("Token expired → refreshing...");

            final success = await _refreshToken();

            if (success) {
              final newToken = await _tokenHelper.tokenLocalGetter();

              e.requestOptions.headers["Authorization"] =
              "Bearer $newToken";

              final retryResponse = await _dio.fetch(e.requestOptions);

              return handler.resolve(retryResponse);
            } else {
              print("Refresh failed → login");
            }
          }

          return handler.next(e);
        },
      ),
    );
  }

  // 🔥 REFRESH TOKEN
  Future<bool> _refreshToken() async {
    try {
      final rtoken = await _tokenHelper.refreshTokenLocalGetter();
      if (rtoken == null) return false;

      final response = await _dio.post(
        '/userAuth/refresh',
        data: {"refreshToken": rtoken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['accessToken'];
        await _tokenHelper.tokenLocalSaver(newAccessToken);
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  // 🔹 GET USER
  Future<Response> getUser() async {
    return await _dio.get('/userAuth/me');
  }
}
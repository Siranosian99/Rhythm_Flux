import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:rhythm_flux/constant/api_config.dart';
import 'package:rhythm_flux/service/models/score_model.dart';
import 'package:rhythm_flux/utils/decode_token_details.dart';
import 'package:rhythm_flux/utils/token_helper.dart';
import '../../utils/token_checker.dart';

class UserService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: {"Content-Type": "application/json"},
      connectTimeout: const Duration(seconds: 2),
      receiveTimeout: const Duration(seconds: 2),
    ),
  );
  final _tokenHelper = TokenHelper();

  UserService() {

    _dio.interceptors.add(

      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenHelper.tokenLocalGetter();
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.requestOptions.path.contains("refresh")) {
            return handler.next(e);
          }
          if (e.response?.statusCode == 401) {
            final token = await _tokenHelper.tokenLocalGetter();

            if (token == null || token.isEmpty) {
              await _tokenHelper.refreshTokenLocalRemover();
              print("------------- pre 1 latest removers");
              return handler.next(e);
            }
            print("q3e${isTokenExpired(token)}");
            final isExpired = isTokenExpired(token);
            // print("sex is:$isExpired");
            if (isExpired) {
              // print("Really Expired:$isExpired and the RefreshedToken function:${await _tokenHelper.refreshTokenLocalGetter()}");
              final success = await refreshToken().timeout(Duration(seconds: 2));
              // print(success);
               // print("----_---_______-------_______${refreshToken()}");
              if  (!success) {
                await _tokenHelper.refreshTokenLocalRemover();
                await _tokenHelper.tokenLocalRemover();
                print("------------- pre 2 latest removers");
                return handler.next(e);
              }

              final newToken = await _tokenHelper.tokenLocalGetter();

              if (newToken == null || newToken.isEmpty) {
                await _tokenHelper.refreshTokenLocalRemover();
                await _tokenHelper.tokenLocalRemover();
                print("------------- pre 3 latest removers");
                return handler.next(e);
              }

              e.requestOptions.headers["Authorization"] = "Bearer $newToken";

              final retryResponse = await _dio.fetch(e.requestOptions);
              return handler.resolve(retryResponse);
            }

            // token expired değil ama 401 → invalid token
            await _tokenHelper.refreshTokenLocalRemover();
            await _tokenHelper.tokenLocalRemover();
            print("------------- latest removers");
          }

          return handler.next(e);
        },
      ),
    );
  }

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

  Future<void> getUser() async {
    try {
      final token = await _tokenHelper.tokenLocalGetter();
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

  Future<bool> refreshToken() async {
    try {
      final rtoken = await _tokenHelper.refreshTokenLocalGetter();

      if (rtoken == null || rtoken.isEmpty) {
        return false;
      }

      final response = await _dio.post(
        ApiConfig.refreshToken,
        data: {"refreshToken": rtoken},
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
  Future<void> saveScore(int score) async {
    try {
      final response = await _dio.post(
        ApiConfig.saveScore,
        data: {"score": score},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
      }
    } catch (e) {
      print("Error Saving Score:${e.toString()}");
    }
  }

  Future<List<int>?> getScores() async {
    try {
      List<int> allScores = [];
      final token = await _tokenHelper.tokenLocalGetter();
      final response = await _dio.get(
        ApiConfig.getScore,
        data: {"accessToken": token},
      );
      if (response.statusCode == 200) {
        final score = response.data['userScores']['scores'];
        allScores = List<int>.from(score);
        return allScores;
      }
    } on DioException catch (e) {
      print(e.response?.data);
    }
    return null;
  }
}

// Future<List<TodosModel>?> fetchUsersTodos() async {
//   try {
//     String? token = await _tokenHelper.tokenLocalGetter();
//
//
//     final response = await _dio.get(
//       '/todoTracker/users',
//       options: Options(headers: {'Authorization': 'Bearer $token'}),
//     );
//
//     if (response.statusCode == 200) {
//       final List<dynamic> todos = response.data;
//       tasks = todos.map((e) => TodosModel.fromJson(e)).toList();
//       emit(TodoAdvnacedState.loadTask(tasks ?? []));
//       return tasks;
//     }
//   } on DioException catch (e) {
//     if (e.response?.statusCode == 401) {
//       // Access token expired → refresh token ile yeni token al
//       final refreshed = await _trackerapi.refreshToken();
//       if (refreshed == true) {
//         // Yeni token ile isteği tekrar gönder
//         String? newToken = await _tokenHelper.tokenLocalGetter();
//         final retry = await _dio.get(
//           '/todoTracker/users',
//           options: Options(headers: {'Authorization': 'Bearer $newToken'}),
//         );
//         final List<dynamic> todos = retry.data;
//         tasks = todos.map((e) => TodosModel.fromJson(e)).toList();
//         emit(TodoAdvnacedState.loadTask(tasks ?? []));
//         return tasks;
//       } else {
//         print("Refresh token failed, user must login");
//         emit(TodoAdvnacedState.loadTask([]));
//       }
//     } else {
//       print("Dio error: ${e.response?.data}");
//       emit(TodoAdvnacedState.loadTask([]));
//     }
//   } catch (e) {
//     print("Error: $e");
//     emit(TodoAdvnacedState.loadTask([]));
//   }
//   return null;
// }

// Future<void> getUser() async {
//   try {
//     final token = await _tokenHelper.tokenLocalGetter();
//
//     final response = await _dio.get(
//       '/userAuth/me',
//       options: Options(headers: {
//         'Authorization': 'Bearer $token',
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       print(response.data);
//     }
//
//   } on DioException catch (e) {
//
//     if (e.response?.statusCode == 401) {
//       // 🔥 refresh token al
//       final refreshToken = await _tokenHelper.refreshTokenGetter();
//
//       final refreshResponse = await _dio.post(
//         '/refresh',
//         data: {"refreshToken": refreshToken},
//       );
//
//       final newAccessToken = refreshResponse.data["accessToken"];
//
//       // 🔥 yeni token kaydet
//       await _tokenHelper.saveAccessToken(newAccessToken);
//
//       // 🔁 TEKRAR DENEME
//       final retryResponse = await _dio.get(
//         '/userAuth/me',
//         options: Options(headers: {
//           'Authorization': 'Bearer $newAccessToken',
//         }),
//       );
//
//       print(retryResponse.data);
//     }
//
//     print(e.response?.data);
//   }
// }

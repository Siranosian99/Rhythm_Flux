import 'package:dio/dio.dart';
import 'package:rhythm_flux/constant/api_config.dart';
import 'package:rhythm_flux/utils/decode_token_details.dart';
import 'package:rhythm_flux/utils/token_helper.dart';

class UserService{
    final  Dio _dio= Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        headers: {"Content-Type": "application/json"},
      ),
    );
    final _tokenHelper=TokenHelper();
    UserService(){
      _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options,handler)async{
        final token=await _tokenHelper.tokenLocalGetter();
        if(token != null){
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
        },
        onError: (DioException e,handler)async{
          if(e.response?.statusCode== 401){
            print("Token expired → refreshing...");
            final succses=await refreshToken();
            if( succses != null && succses) {
              final newToken= await _tokenHelper.tokenLocalGetter();
              e.requestOptions.headers["Authorization"] =
              "Bearer $newToken";

              final retryResponse = await _dio.fetch(e.requestOptions);

              return handler.resolve(retryResponse);
            }
            else{
              DecoderUtils.removeKey();
              print("Key Removed  isVerified Relogin to Save...");
              print("Refresh failed → login");
            }
          }
          return handler.next(e);
        }
      )
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
        print("user Created Brooo:${response.data}");
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
        DecoderUtils.decoder(response.data['accessToken']);
        DecoderUtils.isVerifySaver(DecoderUtils.decoder(response.data['accessToken']));
        _tokenHelper.tokenLocalSaver(response.data['accessToken']);
        _tokenHelper.refreshTokenLocalSaver(response.data['user']['refreshToken']);
        _tokenHelper.userIdLocalSaver(response.data['user']['_id']);
        print("accsses token:-----0------${response.data['accessToken']}");
        print("-----1------${response.data}");
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
      print("ads");
      final response = await _dio.get(
       ApiConfig.getUser,
        data: {"accessToken": token},
      );
      if (response.statusCode == 200) {
        DecoderUtils.decoder(response.data['user']['accessToken']);
        DecoderUtils.isVerifySaver(DecoderUtils.decoder(response.data['accessToken']));
        final isVerified=await DecoderUtils.isVerifiedToken();
        print("isVerified:$isVerified");
        print(response.data);
      }

    } on DioException catch (e) {

      print(e.response?.data);
    }
  }

  Future<bool?> refreshToken() async {
    try {
      final rtoken = await _tokenHelper.refreshTokenLocalGetter();
      if (rtoken == null) return false;

      final response = await _dio.post(
        ApiConfig.refreshToken,
        data: {"refreshToken": rtoken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['accessToken'];
       await _tokenHelper.tokenLocalSaver(newAccessToken);
        return true;
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

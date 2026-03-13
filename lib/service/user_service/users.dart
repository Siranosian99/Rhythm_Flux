import 'package:dio/dio.dart';

class UserService{
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:3000",
      headers: {"Content-Type": "application/json"},
    ),
  );
  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/userAuth/create',
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

}
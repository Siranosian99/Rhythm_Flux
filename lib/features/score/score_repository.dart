import 'package:dio/dio.dart';

import '../../core/constant/api_config.dart';

class ScoreService {
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
      final token = _tokenHelper.tokenLocalGetter();
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
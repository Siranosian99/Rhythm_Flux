import 'package:dio/dio.dart';
import 'package:rhythm_flux/constant/api_config.dart';

class Analyzer{
  final  Dio _dio= Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: {"Content-Type": "multipart/form-data"},
    ),
  );

  Future<void> analyzer(FormData formData)async{
    try{
      final response = await _dio.post(
        ApiConfig.analyzeMusic,
        data: formData,
        options: Options(
          headers: {"Content-Type": "multipart/form-data"},
        ),
        onSendProgress: (sent, total) {
          print("${(sent / total * 100).toStringAsFixed(0)}%");
        },
      );

      print(response.data); // { bpm: ..., beats: [...] }
    }
    catch(e){
      print("Error in alanyze:${e.toString()}");
    }
  }
}
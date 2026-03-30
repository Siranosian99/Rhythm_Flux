import 'package:dio/dio.dart';
import 'package:rhythm_flux/constant/api_config.dart';

class Analyzer{
  final  Dio _dio= Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: {"Content-Type": "application/json"},
    ),
  );
}
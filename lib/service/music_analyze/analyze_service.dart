import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rhythm_flux/constant/api_config.dart';
import 'package:rhythm_flux/utils/token_helper.dart';

import '../../provider/audio_provider.dart';
import '../models/audio_model.dart';

class Analyzer {
  TokenHelper _tokenHelper = TokenHelper();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      // headers: {"Content-Type": "multipart/form-data"},
    ),
  );

  Future<AudioData?> analyzer(FormData formData, String name) async {
    try {
      final response = await _dio.post(
        ApiConfig.analyzeMusic,
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
        onSendProgress: (sent, total) {
          print("${(sent / total * 100).toStringAsFixed(0)}%");
        },
      );
      final bpm = double.parse(response.data['bpm'].toString());

      final beats = (response.data['beats'] as List)
          .map((e) => double.parse(e.toString()))
          .toList();

      final audioData = AudioData(bpm: bpm, beats: beats, name: name);
      await saveRhythms(bpm, beats, name);
      print(response.data); // { bpm: ..., beats: [...] }

      return audioData;
    } catch (e) {
      print("Error in alanyze:${e.toString()}");
    }
    return null;
  }

  Future<void> saveRhythms(double bpm, List<double> beats, String name) async {
    try {
      final token = await _tokenHelper.tokenLocalGetter();
      final response = await _dio.post(
        ApiConfig.saveMusic,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {"bpm": bpm, "beats": beats, "name": name},
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print(response.data);
      }
    } catch (e) {
      print("Error in Save System:${e.toString()}");
    }
  }

  Future<List<AudioData>?> getUserRhythms() async {
    try {
      final token = await _tokenHelper.tokenLocalGetter();

      final response = await _dio.get(
        ApiConfig.getRhythms,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if(response.statusCode == 200 || response.statusCode ==201){
        final List rhythms = response.data['allRhythms'];
        final List<AudioData> audioData = rhythms.map((item) {
          final bpm = double.parse(item['bpm'].toString());
          final name = item['name'];
          final beats = (item['beats'] as List)
              .map((e) => double.parse(e.toString()))
              .toList();

          return AudioData(
            bpm: bpm,
            beats: beats,
            name: name,
          );
        }).toList();
        print("User Rhythms:${response.data}");
        return audioData;
      }

    } catch (e) {
      print("Error fetch Rhythms:${e.toString()}");
    }
    return null;
  }
}

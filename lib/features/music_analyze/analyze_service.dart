import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rhythm_flux/utils/token_helper.dart';

import '../../core/constant/api_config.dart';
import '../../core/constant/app_texts.dart';
import '../../service/models/audio_model.dart';
import '../../widgets/select_bpm_snackBar.dart';

class Analyzer {
  final TokenHelper _tokenHelper = TokenHelper();
  Future<void> init()async{
    await  _tokenHelper.init();
  }
  Analyzer(){
   init();
  }
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      // headers: {"Content-Type": "multipart/form-data"},
    ),
  );

  Future<AudioData?> analyzer(FormData formData, String name,BuildContext context) async {
    try {
      final response = await _dio.post(
        ApiConfig.analyzeMusic,
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
        onSendProgress: (sent, total) {
          print("${(sent / total * 100).toStringAsFixed(0)}%");
        },
      );
      if(response.statusCode ==200 || response.statusCode == 201) {
        final bpm = double.parse(response.data['bpm'].toString());

        final beats = (response.data['beats'] as List)
            .map((e) => double.parse(e.toString()))
            .toList();

        final audioData = AudioData(bpm: bpm, beats: beats, name: name);
        if (!context.mounted) return null;
        await saveRhythms(bpm, beats, name, context);
        print(response.data); // { bpm: ..., beats: [...] }
        if (context.mounted) {
          showBpmSnackBar(
            context,
            AppTexts.isAnalyzeSuccess1,
            AppTexts.isAnalyzeSuccess2,
          );
        }
        return audioData;
      }} catch (e) {
      if (context.mounted) {
        showBpmSnackBar(
          context,
          AppTexts.isAnalyzeFailed1,
          e.toString(),
        );
      }
      print("Error in alanyze:${e.toString()}");
    }
    return null;
  }

  Future<void> saveRhythms(double bpm, List<double> beats, String name,BuildContext context) async {
    try {
      final token = _tokenHelper.tokenLocalGetter();
      final response = await _dio.post(
        ApiConfig.saveMusic,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {"bpm": bpm, "beats": beats, "name": name},
      );
      if (response.statusCode == 201 || response.statusCode == 200) {

        if (!context.mounted) return;
        showBpmSnackBar(context,AppTexts.isReadyToPlay,AppTexts.isReadyToPlay2);

      }
    } catch (e) {
      if (!context.mounted) return;
      showBpmSnackBar(context, AppTexts.isError1,  e.toString());
      print("Error in Save System:${e.toString()}");
    }
  }

  Future<List<AudioData>?> getUserRhythms() async {
    try {
      final token = _tokenHelper.tokenLocalGetter();

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

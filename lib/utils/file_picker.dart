import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rhythm_flux/service/music_analyze/analyze_service.dart';

class FilePickerHelper {

  static Future<void> selectFile() async {
    final analyze = Analyzer();

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a'],
    );
    if (result == null || result.files.single.path == null) {
      return;
    }
    final path = result.files.single.path!;

    final formData = FormData.fromMap({
      "audio": await MultipartFile.fromFile(path, filename: "music.mp3"),
    });
      await analyze.analyzer(formData);
    return;
  }
}

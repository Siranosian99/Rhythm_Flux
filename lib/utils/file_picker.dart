import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import '../features/music_analyze/analyze_service.dart';

class FilePickerHelper {

  static Future<void> selectFile(BuildContext context) async {
    final analyze = Analyzer();

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a'],
      allowMultiple: false,

    );
    if (result == null || result.files.single.path == null) {
      return;
    }
    final path = result.files.single.path!;
    final fileName = result.files.single.name;

    final formData = FormData.fromMap({
      "audio": await MultipartFile.fromFile(path, filename: "music.mp3"),
    });
    if(!context.mounted) return;
    await analyze.analyzer(formData,fileName,context);

  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  static Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
    } else {
      return;
    }
  }
}

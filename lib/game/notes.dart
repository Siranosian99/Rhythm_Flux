import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

Future<void> pickAndUploadMusic() async {
  final result = await FilePicker.platform.pickFiles(type: FileType.audio);
  if (result == null) return;

  final path = result.files.single.path!;

  final dio = Dio();

  final formData = FormData.fromMap({
    "audio": await MultipartFile.fromFile(
      path,
      filename: "music.mp3",
    ),
  });

  final response = await dio.post(
    "http://10.0.2.2:3000/upload", // emulator kullanıyorsan
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
import 'package:flutter/cupertino.dart';
import 'package:rhythm_flux/service/models/audio_model.dart';

class AudioProvider  extends ChangeNotifier{
  AudioData? _audio;

  AudioData? get audio => _audio;
  double get bpm => _audio?.bpm ?? 0;
  List<double> get beats => _audio?.beats ?? [];

  bool get hasData => _audio != null;
  void setAudio(AudioData audio){
    _audio=audio;
    print(_audio);
    notifyListeners();
  }
  void clear() {
    _audio = null;
    notifyListeners();
  }
}
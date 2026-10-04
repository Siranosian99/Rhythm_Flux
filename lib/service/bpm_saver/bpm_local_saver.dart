import 'package:shared_preferences/shared_preferences.dart';

class BpmLocalHelper {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveBpm(double bpm) async {
    await _prefs.setDouble('bpm', bpm);
    print('Saved BPM: $bpm');
  }

  double getBpm() {
    final double bpm = _prefs.getDouble('bpm') ?? 0;
    print('Get BPM: $bpm');
    return bpm;
  }
}
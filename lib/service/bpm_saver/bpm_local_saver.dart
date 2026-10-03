import 'package:shared_preferences/shared_preferences.dart';


class BpmLocalHelper{
  Future<void> saveBpm(double bpm) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('bpm', bpm);
  }
  Future<double> getBpm() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double bpm = prefs.getDouble('bpm') ?? 0;
    return bpm;
  }

}
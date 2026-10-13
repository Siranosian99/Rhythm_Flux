import 'package:just_audio/just_audio.dart';

class AudioManager {
  static final AudioPlayer player = AudioPlayer();

  static Future<void> playMusic(String music) async {
    await player.setAsset('assets/audio/$music.mp3');
    await player.setLoopMode(LoopMode.one);
    await player.play();
  }

  static Future<void> setVolume(double volume) {
    return player.setVolume(volume);
  }

  static Future<void> mute() {
    return player.setVolume(0);
  }

  static Future<void> pause() {
    return player.pause();
  }

  static Future<void> resume() {
    return player.play();
  }

  static Future<void> dispose() {
    return player.dispose();
  }
}
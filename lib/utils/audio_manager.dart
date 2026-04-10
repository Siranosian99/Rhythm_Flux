import 'package:just_audio/just_audio.dart';

class AudioManager {
  static AudioPlayer player = AudioPlayer();

  static void isMusicPlaying(String music) async {
    await player.setAsset('assets/audio/$music.mp3');
    await player.setLoopMode(LoopMode.one);
    player.play();
  }

  static void pause() => player.pause();

  static void resume() => player.play();

  static void dispose() => player.dispose();
}

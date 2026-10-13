import 'dart:async';
import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:rhythm_flux/game/player.dart';
import 'package:rhythm_flux/game/score_board.dart';
import 'package:rhythm_flux/game/score_zone.dart';
import 'package:rhythm_flux/game/timer.dart';
import 'package:rhythm_flux/service/user_service/users.dart';
import 'package:rhythm_flux/states/score_state.dart';
import 'package:rhythm_flux/utils/audio_manager.dart';
import 'package:rhythm_flux/widgets/pause_button.dart';
import '../service/bpm_saver/bpm_local_saver.dart';
import '../widgets/door_widget.dart';

class MyGame extends FlameGame
    with HasCollisionDetection, HasGameRef<MyGame>, TapCallbacks {
  bool isGameOver = false;
  late final UserService _userService;
  late GameState state;
  late double beatDuration;
  final BpmLocalHelper bpmHelper = BpmLocalHelper();
  final VoidCallback onExit;
  late TimerGift timerGift;
  late Player player;
  final gameOverTxt = "GameOver";
  final playTxt = "play";
  bool isPaused = false;

  MyGame({required this.onExit});

  void pauseGame() {
    if (isPaused) return;
    isPaused = true;
    pauseEngine();
    overlays.add('PauseMenu');
  }

  void resumeGame() {
    overlays.remove('PauseMenu');
    isPaused = false;
    resumeEngine();
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    add(
      PauseButton(
        onPause: () {
          if (isGameOver) return;

          if (isPaused) {
            resumeGame();
          } else {
            pauseGame();
          }
        },
      ),
    );
    state = GameState();
    // debugMode =true;
    timerGift = TimerGift();
    await bpmHelper.init();
    final bpm = bpmHelper.getBpm();
    beatDuration = 60 / bpm;
    player = Player();
    _userService = UserService();
    await AudioManager.playMusic(playTxt);
    add(player);
    add(Square(beatDuration: beatDuration));
    add(ScoreBoard());
    add(ScoreZone(player));
    add(timerGift);
   }

  @override
  void onTapDown(TapDownEvent event) {
    if (isPaused || isGameOver) return;
    if (player.velocity.length == 0) {
      player.start();
    } else {
      player.stop();
    }
  }

  void gameOver() {
    if (isGameOver) return;
    isGameOver = true;
    timerGift.stopSurprise();
    pauseEngine();
    AudioManager.pause();
    _userService.saveScore(state.score);
    overlays.add(gameOverTxt);
  }
// siranos1999@gmail.com
  // Vartan1!
  void resetGame() {
    timerGift.stopSurprise();
    removeAll(children);
    add(
      PauseButton(
        onPause: () {
          if (isGameOver) return;

          if (isPaused) {
            resumeGame();
          } else {
            pauseGame();
          }
        },
      ),
    );
    isGameOver = false;
    state.score = 0;
    player = Player();
    add(player);
    player.restart();
    add(Square(beatDuration: beatDuration));
    add(ScoreBoard());
    add(ScoreZone(player));
    timerGift = TimerGift();
    add(timerGift);

    resumeEngine();
    AudioManager.resume();
    overlays.remove(gameOverTxt);
  }

  void exitToMenu() {
    onExit();
  }
}

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
import '../widgets/door_widget.dart';

class MyGame extends FlameGame
    with HasCollisionDetection, HasGameRef<MyGame>, TapCallbacks {
  bool isGameOver = false;
  late final UserService _userService;
  late GameState state;

  final VoidCallback onExit;
  late Player player;
  final gameOverTxt = "GameOver";
  final playTxt = "play";

  MyGame({required this.onExit});

  @override
  FutureOr<void> onLoad() async {
    state = GameState();
    // debugMode =true;
    player = Player();
    _userService = UserService();
    AudioManager.isMusicPlaying(playTxt);
    add(player);
    // add(Player());
    add(Square());
    add(ScoreBoard());
    add(ScoreZone(player));
    add(TimerGift());
    // add(ScoreBoard());
    // add(Maze());
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (player.velocity.length == 0) {
      player.start();
    } else {
      player.stop();
    }
  }

  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();
    AudioManager.pause();
    _userService.saveScore(state.score);
    overlays.add(gameOverTxt);
  }

  void resetGame() {
    removeAll(children);
    isGameOver = false;
    game.state.score = 0;

    add(player);
    add(Square());
    add(ScoreBoard());
    add(ScoreZone(player));
    add(TimerGift());
    resumeEngine();
    AudioManager.resume();
    overlays.remove(gameOverTxt);
  }

  void exitToMenu() {
    onExit();
  }
}

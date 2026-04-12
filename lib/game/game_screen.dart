import 'dart:async';
import 'dart:ui';
import 'package:just_audio/just_audio.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

// import 'package:flame_audio/flame_audio.dart';
import 'package:rhythm_flux/game/player.dart';
import 'package:rhythm_flux/game/score_board.dart';
import 'package:rhythm_flux/game/score_zone.dart';
import 'package:rhythm_flux/service/user_service/users.dart';
import 'package:rhythm_flux/states/score_state.dart';
import 'package:rhythm_flux/utils/audio_manager.dart';

import '../widgets/door_widget.dart';

class MyGame extends FlameGame with HasCollisionDetection, HasGameRef<MyGame> {
  bool isGameOver = false;
  late final UserService _userService;
  final GameState state = GameState();
  final VoidCallback onExit;
  late Player player;
  MyGame({required this.onExit});

  @override
  FutureOr<void> onLoad() async {
    // debugMode =true;
     player=Player();
     _userService=UserService();
    AudioManager.isMusicPlaying("play");
    add(player);
    // add(Player());
    add(Square());
    add(ScoreBoard());
    add(ScoreZone(player));

    // add(ScoreBoard());
    // add(Maze());
  }



  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();
    AudioManager.pause();
    _userService.saveScore(state.score);
    overlays.add('GameOver');
  }

  void resetGame() {
    isGameOver = false;
    removeAll(children);
    game.state.score = 0;

    add(Player());
    add(Square());
    add(ScoreBoard());
    resumeEngine();
    AudioManager.resume();
    overlays.remove('GameOver');
  }

  void exitToMenu() {
    onExit();
  }
}

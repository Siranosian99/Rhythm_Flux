import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:rhythm_flux/game/player.dart';
import 'package:rhythm_flux/game/score_board.dart';
import 'package:rhythm_flux/states/score_state.dart';

import '../widgets/door_widget.dart';

class MyGame extends FlameGame with HasCollisionDetection ,HasGameRef<MyGame> {
  bool isGameOver = false;
  final GameState state = GameState();
  final VoidCallback onExit;
  MyGame({required this.onExit});
  @override
  FutureOr<void> onLoad() async {
    // debugMode =true;
    add(Player());
    add(Square());
    add(ScoreBoard());
    // add(ScoreBoard());
    // add(Maze());

  }

  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

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

    overlays.remove('GameOver');

  }
  void exitToMenu(){
    onExit();
  }
}
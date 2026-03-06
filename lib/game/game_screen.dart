import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:rhythm_flux/game/player.dart';
import 'package:rhythm_flux/game/score_board.dart';
import 'package:rhythm_flux/states/score_state.dart';

import '../widgets/door_widget.dart';

class MyGame extends FlameGame with HasCollisionDetection ,HasGameRef<MyGame> {
  final GameState  state= GameState();
  @override
  FutureOr<void> onLoad() async {
    debugMode =true;
    add(Player());
    add(Square());
    add(ScoreBoard());
    // add(ScoreBoard());
    // add(Maze());

  }
}
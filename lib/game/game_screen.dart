import 'dart:async';

import 'package:flame/game.dart';
import 'package:rhythm_flux/game/player.dart';
import 'package:rhythm_flux/game/score_board.dart';

import '../widgets/door_widget.dart';

class MyGame extends FlameGame with HasCollisionDetection {
  @override
  FutureOr<void> onLoad() async {
    debugMode =true;
    add(Player());
    add(Square());
    add(ScoreBoard());
    // add(Maze());

  }
}
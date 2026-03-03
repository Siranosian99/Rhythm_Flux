import 'package:flame/game.dart';
import 'package:rhythm_flux/game/player.dart';
import 'package:rhythm_flux/game/score_board.dart';

import '../widgets/door_widget.dart';

class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    add(Player(position:Vector2(220,900)));
    add(Square());
    add(ScoreBoard());
    // add(Maze());
  }
}
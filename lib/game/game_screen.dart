import 'package:flame/game.dart';
import 'package:rhythm_flux/game/player.dart';

class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    add(Player(position:Vector2(220,900)));
    // add(Maze());
  }
}
import 'package:flame/components.dart';

import '../game/game_screen.dart';
import '../game/player.dart';
import '../widgets/door_widget.dart';

abstract class Surprise<T> {
  final MyGame game;

  Surprise(this.game);

  void surprise([T? value]);
}

class IncreaseScore extends Surprise<int> {
  IncreaseScore(super.game);

  @override
  void surprise([int? score]) {
    game.state.score += 5;
    print("Score Increased by 5");
  }
}

class DecreaseScore extends Surprise<int> {
  DecreaseScore(super.game);

  @override
  void surprise([int? score]) {
    game.state.score -= 5;
    print("Score Decreased by 5");
  }
}

class DoorTransparent extends Surprise<bool> {
  DoorTransparent(super.game);
  @override
  void surprise([bool? value]) {
    Paddle.isTransparent = value ?? !Paddle.isTransparent;

    print("Transparent Value: ${Paddle.isTransparent}");
  }
}

class IncreaseSpeed extends Surprise<bool> {
  IncreaseSpeed(super.game);

  @override
  void surprise([bool? value]) {

      Player.isFast = !Player.isFast;

    print("Speed isFast: ${Player.isFast}");
  }
}

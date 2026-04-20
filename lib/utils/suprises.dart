import 'package:flame/components.dart';

import '../game/game_screen.dart';
import '../game/player.dart';
import '../widgets/door_widget.dart';

abstract class Surprise<T> {
  final MyGame game;

  Surprise(this.game);

  void surprise([T? value]);
  void stop();
}

class IncreaseScore extends Surprise<int> {
  IncreaseScore(super.game);

  @override
  void surprise([int? score]) {
    game.state.score += 5;
    print("Score Increased by 5");
  }

  @override
  void stop() {
  }}

class DecreaseScore extends Surprise<int> {
  DecreaseScore(super.game);

  @override
  void surprise([int? score]) {
    game.state.score -= 5;
    print("Score Decreased by 5");
  }

  @override
  void stop() {
  }
}

class DoorTransparent extends Surprise<bool> {
  DoorTransparent(super.game);
  @override
  void surprise([bool? value]) {
    Paddle.isTransparent = true;
    print("Transparent ON");
  }

  void stop() {
    Paddle.isTransparent = false;
    print("Transparent OFF");
  }
}

class IncreaseSpeed extends Surprise<bool> {
  IncreaseSpeed(super.game);

  @override
  void surprise([bool? value]) {
    Player.isFast = true;
    print("Speed ON");
  }

  void stop() {
    Player.isFast = false;
    print("Speed OFF");
  }
}

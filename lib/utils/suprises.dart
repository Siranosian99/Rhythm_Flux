import 'package:flame/components.dart';

import '../game/game_screen.dart';
import '../widgets/door_widget.dart';

abstract class Suprises<T> {
  final MyGame game;

  Suprises(this.game);

  void suprise([T? value]) {}
}

class IncreaseScore extends Suprises<int> {
  IncreaseScore(super.game);

  @override
  void suprise([int? score]) {
    game.state.score += 5;
    print("Score Increased by 5");
  }
}

class DecreaseScore extends Suprises<int> {
  DecreaseScore(super.game);

  @override
  void suprise([int? score]) {
    game.state.score -= 5;
    print("Score Decreased by 5");
  }
}

class DoorTransparent extends Suprises<bool> {
  DoorTransparent(super.game);
  @override
  void suprise([bool? value]) {
    Paddle.isTransparent = value ?? !Paddle.isTransparent;

    print("Transparent: ${Paddle.isTransparent}");
  }
}

// class IncreaseSpeed extends Suprises {
//   @override
//   void suprise() {
//     super.suprise();
//   }
// }

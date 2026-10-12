import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:rhythm_flux/game/game_screen.dart';
import 'package:rhythm_flux/game/player.dart';

import '../states/score_state.dart';

class ScoreZone extends PositionComponent
    with CollisionCallbacks, HasGameRef<MyGame>{
  bool counted = false;
  late Player player;
  final bottom=398;
  final top=600;
  ScoreZone(this.player)
      : super(
    size: Vector2(230, 230),
    position: Vector2(120, 390),
  );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is Player) {
      final playerTop = other.y - other.height / 2;
      final playerBottom = other.y + other.height / 2;
      if (playerBottom < bottom || playerTop > top) {
        game.state.addScore();
      }
    }
  }
}

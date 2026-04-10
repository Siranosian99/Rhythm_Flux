import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:rhythm_flux/game/game_screen.dart';
import 'package:rhythm_flux/game/player.dart';

class ScoreZone extends PositionComponent with CollisionCallbacks {
  bool counted = false;

  ScoreZone(): super(
    size: Vector2(412,200),
    anchor: Anchor.topLeft,
    position: Vector2(10, 400),
  );

  @override
  Future<void> onLoad() async {
    add(
      RectangleHitbox(
        collisionType: CollisionType.passive,
      ),
    );

  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    if (other is Player && !counted) {
      counted = true;

      // (parent as MyGame).increaseScore();
    }
  }
}
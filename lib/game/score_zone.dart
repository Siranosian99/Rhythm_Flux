import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:rhythm_flux/game/game_screen.dart';
import 'package:rhythm_flux/game/player.dart';

import '../states/score_state.dart';

class ScoreZone extends PositionComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  bool counted = false;
  final GameState state = GameState();
  final Player player;

  ScoreZone(this.player)
    : super(
        size: Vector2(412, 200),
        anchor: Anchor.topLeft,
        position: Vector2(10, 350),
      );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Player) {
      if (player.position.x > position.x + size.x) {
        final game = findGame() as MyGame;
        game.state.addScore();
        print("SCORE +1 ✅");
      }
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}

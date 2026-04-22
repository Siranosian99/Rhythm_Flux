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

  // @override
  // void onCollisionStart(
  //     Set<Vector2> intersectionPoints,
  //     PositionComponent other,
  //     ) {
  //   if (other is Player) {
  //     final top = player.y - player.height / 2;
  //     final bottom = player.y + player.height / 2;
  //
  //     if (top < 398 || bottom > 600) {
  //       final game = findGame() as MyGame;
  //       game.state.addScore();
  //       print("SCORE +1 ✅");
  //     }
  //   }
  //
  //   super.onCollisionStart(intersectionPoints, other);
  // }
  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is Player) {
      final playerTop = other.y - other.height / 2;
      final playerBottom = other.y + other.height / 2;

      // print("Player Top: $playerTop, Bottom: $playerBottom");


      if (playerBottom < bottom || playerTop > top) {
        game.state.addScore();
      }
    }
  }
}

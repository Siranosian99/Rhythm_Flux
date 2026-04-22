import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:rhythm_flux/game/game_screen.dart';

import '../widgets/door_widget.dart';

class Player extends SpriteComponent
    with TapCallbacks, HasGameRef<MyGame>, CollisionCallbacks {
  Player()
    : super(
        size: Vector2.copy(Vector2(50, 200)),
        anchor: Anchor.center,
        position: Vector2(210, 840),
      );
  double speed = 500;
  static bool isFast = false;
  static bool isMoving = false;
  final pos = Vector2.zero();
  late Vector2 velocity;
  final posMain = Vector2(0, 200);
  final double speedMove = 100;

  @override
  FutureOr<void> onLoad() async {
    add(RectangleHitbox());
    sprite = await Sprite.load('spaceman.png');
    velocity = pos;
  }

  @override
  void onTapUp(TapUpEvent event) {
    speed += speed;
  }

  void stop() {
    velocity=pos;
  }

  void start() {
    velocity = posMain;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += isFast ? speed * dt * speedMove : speed * dt;
    if ((position.y - size.y / 2 <= 0)) {
      position.y = size.y / 2;
      speed = speedMove;
    } else if ((position.y + size.y / 2 >= gameRef.size.y)) {
      position.y = gameRef.size.y - size.y / 2;
      speed = -speedMove;
    } else {
      position += velocity * dt;
    }
  }
}

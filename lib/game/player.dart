import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import 'package:rhythm_flux/game/game_screen.dart';

import '../widgets/door_widget.dart';

class Player extends SpriteComponent with TapCallbacks, HasGameRef<MyGame>,CollisionCallbacks {
  Player()
    : super(size: Vector2.copy(Vector2(50,200)), anchor: Anchor.center,position:Vector2(210,840));
  double speed = 500;
 static bool isFast=false;
 static bool isMoving=false;
  @override
  FutureOr<void> onLoad() async {
    add(RectangleHitbox());
    sprite = await Sprite.load('spaceman.png');
  }
  Vector2 velocity = Vector2.zero();

  @override
  void onTapUp(TapUpEvent info) {
    speed += speed;
  }
  void stop(){
    velocity = Vector2.zero();
  }
  void start() {
    velocity = Vector2(0, 200);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += isFast ? speed * dt * 100:speed * dt ;
    if ((position.y - size.y / 2 <= 0 )) {
      position.y = size.y / 2;
      speed = 100;
    }
   else if ((position.y + size.y / 2 >= gameRef.size.y)) {
      position.y = gameRef.size.y - size.y / 2;
      speed = -100;
    }
   else{
      position += velocity * dt;

    }
  }


}

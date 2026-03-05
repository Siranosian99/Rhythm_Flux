import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:flame/extensions.dart';
import 'package:rhythm_flux/game/game_screen.dart';

import '../widgets/door_widget.dart';

class Player extends SpriteComponent with TapCallbacks, HasGameRef<MyGame> {
  Player()
    : super(size: Vector2.all(290), anchor: Anchor.center,position:Vector2(220,900));
  double speed = 500; // yukarı gidiyor

  @override
  FutureOr<void> onLoad() async {
    position.x=220;
    position.y=500;
    add(RectangleHitbox());
    sprite = await Sprite.load('spaceman.png');
  }

  @override
  void onTapUp(TapUpEvent info) {
    // size += Vector2.all(50);
    speed += speed++;
  }

  @override
  void update(double dt) {
    super.update(dt);
    // position.y += speed * dt;
    // if (position.y - size.y / 2 <= 0) {
    //   position.y = size.y / 2;
    //   speed = 100;
    // }
    // if (position.y + size.y / 2 >= gameRef.size.y) {
    //   position.y = gameRef.size.y - size.y / 2;
    //   speed = -100;
    // }
  }
}

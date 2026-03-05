import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:rhythm_flux/game/player.dart';

import '../game/game_screen.dart';

class Square extends RectangleComponent
    with TapCallbacks, HasGameRef<MyGame>, CollisionCallbacks {
  static int speed = -100;
  static const squareSize = 50.0;
  static const indicatorSize = 6.0;

  // static final Paint red = BasicPalette.red.paint();
  // static final Paint blue = BasicPalette.blue.paint();
  Square() : super();

  // Square(Vector2 position)
  //     : super(
  //   position: Vector2(122,121),
  //   size: Vector2.all(squareSize),
  //   anchor: Anchor.center,
  // );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    // add(
    //   RectangleComponent(
    //     size: Vector2(20, 100),
    //     anchor: Anchor.centerRight,
    //     position: Vector2(
    //       gameRef.size.x / 1.2,        // ekranın en sağı
    //       gameRef.size.y / 2,    // dikey ortası
    //     ),
    //     paint: Paint()..color = Colors.blueAccent,
    //   ),
    // );
    // add(
    //   RectangleComponent(
    //     size: Vector2(20, 100),
    //     anchor: Anchor.centerLeft,
    //     position: Vector2(
    //      60,                     // ekranın solu
    //       gameRef.size.y / 2,    // dikeyde ortala
    //     ),
    //     paint: Paint()..color = Colors.purpleAccent,
    //     // paintLayers: [Paint()..color = Colors.purpleAccent,]
    //   ),
    // );
    add(
      Paddle(
        speed: -120,
        isLeft: true,
        color: Colors.purpleAccent,
        moveX: true,
        maxDistance: 100,
        startX: 120,
      ),
    );
    add(
      Paddle(
        speed: -120,
        isLeft: false,
        color: Colors.blueAccent,
        moveX: true,
        maxDistance: 100,
        startX: 350,
      ),
    );

  }

  @override
  void update(double dt) {
    super.update(dt);
    // speed +=speed *2;
    // position.y += 1;
    // angle += speed * dt;
    // angle %= 2 * math.pi;
  }

  // @override
  // void onTapDown(TapDownEvent event) {
  //   removeFromParent();
  //   event.handled = true;
  // }
}

class Paddle extends RectangleComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  double speed;
  final bool isLeft;
  final Color color;
  final bool moveX;
  final double maxDistance;
  final double startX;

  Paddle({
    required this.color,
    required this.speed,
    required this.isLeft,
    required this.moveX,
    required this.maxDistance,
    required this.startX,
  }) : super(
         size: Vector2(20, 100),
         anchor: Anchor.center,
         paint: Paint()..color = color,
       );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
    double centerY = gameRef.size.y / 2;

    if (isLeft) {
      position = Vector2(80, centerY);
    } else {
      position = Vector2(gameRef.size.x - 80, centerY);
    }

  }


  @override
  void update(double dt) {
    super.update(dt);
    position.x += speed * dt;
    if ((position.x - startX).abs() >= maxDistance) {
      speed = -speed;
    }
    // speed++;
    // position.x =speed;
  }
  @override
  void onCollisionStart(Set<Vector2> points, PositionComponent other) {
    if (other is Player) {
      print("Çarpışma oldu!");
    }
    super.onCollisionStart(points, other);
  }
}

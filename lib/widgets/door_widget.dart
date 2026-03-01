import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import '../game/game_screen.dart';

class Square extends RectangleComponent with TapCallbacks , HasGameRef<MyGame>{
  static const speed = 1;
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
  Future<void> onLoad() async {
    super.onLoad();
    add(
      RectangleComponent(
        size: Vector2(20, 100),
        anchor: Anchor.centerRight,
        position: Vector2(
          gameRef.size.x / 1.2,        // ekranın en sağı
          gameRef.size.y / 2,    // dikey ortası
        ),
        paint: Paint()..color = Colors.blueAccent,
      ),
    );
    add(
      RectangleComponent(
        size: Vector2(20, 100),
        anchor: Anchor.centerLeft,
        position: Vector2(
         60,                     // ekranın solu
          gameRef.size.y / 2,    // dikeyde ortala
        ),
        paint: Paint()..color = Colors.purpleAccent,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    angle += speed * dt;
    angle %= 2 * math.pi;
  }

  // @override
  // void onTapDown(TapDownEvent event) {
  //   removeFromParent();
  //   event.handled = true;
  // }
}
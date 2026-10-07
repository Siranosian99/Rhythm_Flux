import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:rhythm_flux/game/player.dart';
import '../game/game_screen.dart';

class Square extends RectangleComponent
    {
  final double beatDuration;
  Square({
    required this.beatDuration,
  });


  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    add(
      Paddle(
        speed: 100 / beatDuration,
        //-120
        isLeft: true,
        color: Colors.purpleAccent,
        moveX: true,
        maxDistance: 100,
        startX: 120,
      ),
    );
    add(
      Paddle(
        speed: 100 / beatDuration,
        //-120
        isLeft: false,
        color: Colors.blueAccent,
        moveX: true,
        maxDistance: 100,
        startX: 350,
      ),
    );
  }
}

class Paddle extends RectangleComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  double speed;
  final bool isLeft;
  final Color color;
  final bool moveX;
  final double maxDistance;
  final double startX;
  static bool isTransparent = false;

  Paddle({
    required this.color,
    required this.speed,
    required this.isLeft,
    required this.moveX,
    required this.maxDistance,
    required this.startX,
  }) : super(
         size: Vector2(30, 200),
         anchor: Anchor.center,
         // paint: Paint()..color = isTransparent ?Colors.transparent:color,
       );

  @override
  void render(Canvas canvas) {
    paint.color = isTransparent ? Colors.transparent : color;
    super.render(canvas);
  }

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
    position.x += speed  * dt;
    if ((position.x - startX).abs() >= maxDistance) {
      speed = -speed;
    }
    // speed++;
    // position.x =speed;
  }

  @override
  void onCollisionStart(Set<Vector2> points, PositionComponent other) {
    if (other is Player) {

      gameRef.gameOver();
      game.add(
        ParticleSystemComponent(
          position: points.first,
          particle: Particle.generate(
            count: 20,
            lifespan: 0.5,
            generator: (i) => AcceleratedParticle(
              acceleration: Vector2(1, 100),
              speed: Vector2.random() * 100,
              child: CircleParticle(
                radius: 1,
                paint: Paint()..color = Colors.red,
              ),
            ),
          ),
        ),
      );
      FlameAudio.play('death_music.wav', volume: 0.3);
    }
    super.onCollisionStart(points, other);
  }
}

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/timer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    add(MyTimer());
  }
}

class MyTimer extends TextComponent {
  late Timer timer;
  late Timer surpriseTimer;

  int timeLeft = 5;       // kısa yaptım hızlı test için
  int effectTime = 3;

  bool isEffect = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    position = Vector2(200, 200);

    timer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (isEffect) return;

        timeLeft--;
        print("Countdown: $timeLeft");

        if (timeLeft <= 0) {
          startEffect();
        }
      },
    );

    timer.start();
  }

  void startEffect() {
    isEffect = true;
    effectTime = 3;

    print("🔥 EFFECT START");

    surpriseTimer = Timer(
      0.5,
      repeat: true,
      onTick: () {
        print("⚡ EFFECT RUNNING");

        effectTime--;

        if (effectTime <= 0) {
          stopEffect();
        }
      },
    );

    surpriseTimer.start();
  }

  void stopEffect() {
    surpriseTimer.stop();
    isEffect = false;

    timeLeft = 5;

    print("✅ EFFECT END → RESET");
  }

  @override
  void update(double dt) {
    timer.update(dt);

    if (isEffect) {
      surpriseTimer.update(dt);
    }

    text = isEffect
        ? "EFFECT: $effectTime"
        : "TIME: $timeLeft";
  }
}
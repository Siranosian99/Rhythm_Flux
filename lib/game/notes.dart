// =======================
// TIMER GIFT (FIXED)
// =======================

import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rhythm_flux/game/game_screen.dart';
import 'package:rhythm_flux/game/player.dart';
import '../utils/suprises.dart';

class TimerGift extends TextComponent
    with CollisionCallbacks, HasGameRef<MyGame> {

  TimerGift();

  late Timer timer;
  late Timer timerSurprise;

  int timeLeft = 5;
  bool isSurprise = false;

  late final List<Surprise> surprises;
  Surprise? activeSurprise;

  final Random random = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Create surprises ONCE
    surprises = [
      IncreaseScore(gameRef),
      DoorTransparent(gameRef),
      IncreaseSpeed(gameRef),
      DecreaseScore(gameRef),
    ];

    // MAIN TIMER
    timer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (isSurprise) return;

        timeLeft--;

        if (timeLeft <= 0) {
          startSurprise();
        }
      },
    );

    timer.start();

    position = Vector2(100, 900);
    anchor = Anchor.bottomCenter;
  }

  // =======================
  // START SURPRISE MODE
  // =======================
  void startSurprise() {
    if (isSurprise) return;

    isSurprise = true;
    int surpriseTimer = 5;
    activeSurprise = null;

    timerSurprise = Timer(
      1,
      repeat: true,
      onTick: () {
        // pick ONLY ONE surprise at a time
        if (activeSurprise == null) {
          activeSurprise = surprises[random.nextInt(surprises.length)];
          activeSurprise!.surprise();
        }

        surpriseTimer--;

        if (surpriseTimer <= 0) {
          stopSurprise();
        }
      },
    );

    timerSurprise.start();
  }

  // =======================
  // STOP SURPRISE MODE
  // =======================
  void stopSurprise() {
    isSurprise = false;

    // turn off active effect
    activeSurprise?.stop();
    activeSurprise = null;

    timerSurprise.stop();

    // reset normal timer
    timeLeft = 5;
  }

  @override
  void update(double dt) {
    timer.update(dt);

    if (isSurprise) {
      timerSurprise.update(dt);
    }

    text = isSurprise
        ? "SURPRISE!!"
        : "Surprise Timer: $timeLeft";
  }
}



//the keyboard
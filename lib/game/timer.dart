import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythm_flux/game/game_screen.dart';
import '../utils/suprises.dart';

class TimerGift extends TextComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  TimerGift() :super(
      position :Vector2(120, 900),
      anchor : Anchor.bottomCenter);
  late TextComponent scoreValue;
  late Timer timer;
   Timer? timerSurprise;
  int timeLeft = 10;
  bool isSurprise = false;
  Surprise? activeSurprises;
  late final List<Surprise> surprises;
  final Random random = Random();
  final surpriseText = "SURPRISE!!";

  final timerText = "Surprise Timer:";

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    surprises = [
      IncreaseScore(gameRef),
      DoorTransparent(gameRef),
      IncreaseSpeed(gameRef),
      DecreaseScore(gameRef),
    ];

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
     scoreValue = TextComponent(
      anchor: Anchor.center,
      position: size / 2,
      text: '$timerText $timeLeft',
      textRenderer: TextPaint(
        style: GoogleFonts.orbitron(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: const Color(0xFFFFD166),
          shadows: const [
            Shadow(
              color: Color(0xFFFF9F1C),
              blurRadius: 14,
              offset: Offset(0, 0),
            ),
            Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(2, 3)),
          ],
        ),
      ),
    );
    add(scoreValue);
  }

  void startSurprise() {

    int surpriseTimer = 6;
    timerSurprise = Timer(
      0.5,
      repeat: true,
      onTick: () {
        if (activeSurprises == null) {
          activeSurprises = surprises[random.nextInt(surprises.length)];
          activeSurprises?.surprise();
        }
        surpriseTimer--;
        if (surpriseTimer <= 0) {
          stopSurprise();
        }
      },
    );
    isSurprise = true;
    timerSurprise?.start();
  }

  void stopSurprise() {
    timeLeft = 10;
    isSurprise = false;
    activeSurprises?.stop();
    activeSurprises = null;
    timerSurprise?.stop();

  }

  @override
  void update(double dt) {

    timer.update(dt);
    if (isSurprise) {
      timerSurprise?.update(dt);
    }
    scoreValue.text = isSurprise
        ? surpriseText
        : '$timerText $timeLeft';
  }
  @override
  void onRemove() {
    timer.stop();
    timerSurprise?.stop();
    activeSurprises?.stop();
    super.onRemove();
  }
}



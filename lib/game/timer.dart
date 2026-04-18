import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythm_flux/game/game_screen.dart';
import 'package:rhythm_flux/game/player.dart';
import '../utils/suprises.dart';

class TimerGift extends TextComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  TimerGift() : super();
  late Timer timer;
  late Timer timerSurprise;
  int timeLeft = 10;
  bool isSurprise = false;
  final random=Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();
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
    final scoreText = TextComponent(
      anchor: Anchor.center,
      position: size / 2,
      textRenderer: TextPaint(
        style: GoogleFonts.roboto(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(blurRadius: 4, color: Colors.black45, offset: Offset(2, 2)),
          ],
          textStyle: TextStyle(),
        ),
      ),
    );

    position = Vector2(100, 900);
    anchor = Anchor.bottomCenter;
    add(scoreText);
  }

  void startSurprise() {
    isSurprise = true;
    int surpriseTimer = 3;
    timerSurprise = Timer(
      1,
      repeat: true,
      onTick: () {
        // final surprises = [
        //   IncreaseScore(gameRef).surprise(),
        //   DoorTransparent(gameRef).surprise(),
        //   IncreaseSpeed(gameRef).surprise(),
        //   DecreaseScore(gameRef).surprise(),
        // ];
        // selected.surprise();
        // action.surprise();
        // transparent.surprise();
        // faster.surprise();
        // final selected = surprises[random.nextInt(surprises.length)];
        // surprises.random();
        IncreaseScore(gameRef).surprise();
        DoorTransparent(gameRef).surprise();
        IncreaseSpeed(gameRef).surprise(true);
        DecreaseScore(gameRef).surprise();
        surpriseTimer--;
        if (surpriseTimer <= 1) {
          stopSurprise();
        }
        print("isSurpriseP:$isSurprise");
      },
    );
    timerSurprise.start();
  }

  void stopSurprise() {
    isSurprise = false;
    // Player.isFast=false;
    timerSurprise.stop();
    timeLeft = 10;
  }

  @override
  void update(double dt) {
    timer.update(dt);
    if (isSurprise) {
      timerSurprise.update(dt);
    }
    text = "Surprise Timer:$timeLeft";
  }
}

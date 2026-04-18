import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythm_flux/game/game_screen.dart';
import '../utils/suprises.dart';

class TimerGift extends TextComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  TimerGift() : super();
  late Timer timer;
  late Timer timerSurprise;
  int timeLeft = 10;
  bool isSurprise = false;

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

        // print("2 saniye sonra çalıştı");
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
        final action = IncreaseScore(gameRef);
        action.surprise();
        final transparent = DoorTransparent(gameRef);
        transparent.surprise();
        final faster = IncreaseSpeed(gameRef);
        faster.surprise();
        surpriseTimer--;
        if (surpriseTimer <= 0) {
          stopSurprise();
          isSurprise=false;
        }
        print("isSurpriseP:$isSurprise");
        // print("2 saniye sonra çalıştı");
      },
    );
    timerSurprise.start();
  }

  void stopSurprise() {
    timerSurprise.stop();
    isSurprise = false;
    timeLeft = 10;
  }

  @override
  void update(double dt) {
    // timer.update(dt);
    // if (isSurprise) {
    //   timerSurprise.update(dt);
    // }
    text = "Surprise Timer:$timeLeft";
  }

  // Skoru güncellemek için
  // void updateScore(int value) {
  //   score = value;
  //   // Score text'i güncelle
  //   final box = children.first as RectangleComponent;
  //   final text = box.children.first as TextComponent;
  //   text.text = "Score: $score";
}

//import 'package:flame/components.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'game_screen.dart';
//
// class TimerGift extends TextComponent with HasGameRef<MyGame> {
//
//   TimerGift()
//       : super(
//     text: "Score: 0",
//     position: Vector2(60, 50),
//     anchor: Anchor.topLeft,
//     textRenderer: TextPaint(
//       style: GoogleFonts.roboto(
//         fontSize: 28,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//         shadows: [
//           Shadow(
//             blurRadius: 4,
//             color: Colors.black45,
//             offset: Offset(2, 2),
//           ),
//         ],
//       ),
//     ),
//   );
//
//   @override
//   void update(double dt) {
//     text = "Score: ${game.state.score}";
//   }
// }


// begin 10s then 2s doing that then also 10s and then 10s normal
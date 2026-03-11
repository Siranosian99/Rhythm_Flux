import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythm_flux/game/game_screen.dart';

class ScoreBoard extends TextComponent with  CollisionCallbacks,HasGameRef<MyGame>{
  static int score = 1;
  ScoreBoard() : super();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final scoreText = TextComponent(
      anchor: Anchor.center,
      position: size / 2,
      textRenderer: TextPaint(
        style: GoogleFonts.roboto(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 4,
              color: Colors.black45,
              offset: Offset(2, 2),
            ),
          ],
          textStyle:TextStyle(

          )
        ),
      ),
    );

    position = Vector2(60, 50);
    anchor = Anchor.topCenter;
    add(scoreText);

  }

  @override
  void update(double dt) {
    text = "Score: ${game.state.score}";
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
// class ScoreBoard extends TextComponent with HasGameRef<MyGame> {
//
//   ScoreBoard()
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
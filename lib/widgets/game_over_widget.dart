import 'package:flutter/material.dart';
import 'package:rhythm_flux/constant/app_texts.dart';
import 'package:rhythm_flux/game/game_screen.dart';
import 'package:rhythm_flux/game/score_board.dart';
import 'package:rhythm_flux/widgets/restart_button_widget.dart';
class GameOverOverlay extends StatelessWidget {
  final MyGame game;
  const GameOverOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF0F1020), // koyu arka plan
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF6C63FF), // purple border
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.4),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: const Color(0xFF3A86FF).withOpacity(0.3),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // GAME OVER
                  const Text(
                    "GAME OVER",
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                      shadows: [
                        Shadow(
                          color: Colors.red,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // SCORE
                  Text("${AppTexts.yourScore}: ${game.state.score}",
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: Color(0xFF6C63FF),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EButtons(buttonText:AppTexts.restart,onPressed:(){
                  game.resetGame();
                },),
                const SizedBox(width: 20),
                EButtons(buttonText:AppTexts.cancel,onPressed:(){
                  game.resetGame();
                },),
              ],
            ),

          ],
        ),
      ),
    );
  }
}


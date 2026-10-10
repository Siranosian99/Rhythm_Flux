
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythm_flux/game/game_screen.dart';

class ScoreBoard extends PositionComponent
    with HasGameRef<MyGame> {
  late TextComponent scoreLabel;
  late TextComponent scoreValue;

  int previousScore = -1;

  ScoreBoard()
      : super(
    position: Vector2(20, 35),
    size: Vector2(150, 78),
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    scoreLabel = TextComponent(
      text: 'S C O R E',
      position: Vector2(14, 10),
      textRenderer: TextPaint(
        style: GoogleFonts.roboto(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF54F6FF),
          letterSpacing: 2,
        ),
      ),
    );

    scoreValue = TextComponent(
      text: '0',
      position: Vector2(14, 30),
      textRenderer: TextPaint(
        style: GoogleFonts.orbitron(
          fontSize: 27,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: const [
            Shadow(
              color: Color(0xFF54F6FF),
              blurRadius: 10,
            ),
          ],
        ),
      ),
    );

    add(scoreLabel);
    add(scoreValue);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final panelPaint = Paint()
      ..color = const Color(0xE6101830);

    final borderPaint = Paint()
      ..color = const Color(0xFF54F6FF).withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final panelRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x, size.y),
      const Radius.circular(14),
    );

    canvas.drawRRect(panelRect, panelPaint);

    canvas.drawRRect(panelRect, borderPaint);

    final linePaint = Paint()
      ..color = const Color(0xFF9D65FF)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(14, size.y - 9),
      Offset(size.x - 14, size.y - 9),
      linePaint,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    final currentScore = game.state.score;

    if (currentScore != previousScore) {
      scoreValue.text = currentScore.toString().padLeft(5, '0');
      previousScore = currentScore;
    }
  }
}

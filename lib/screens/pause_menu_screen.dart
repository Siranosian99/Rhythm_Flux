import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class PauseButton extends PositionComponent
    with TapCallbacks {
  final VoidCallback onPause;

  PauseButton({
    required this.onPause,
  }) : super(
    size: Vector2.all(60),
    anchor: Anchor.bottomRight,
    priority: 100,
  );

  final Paint _backgroundPaint = Paint()
    ..color = const Color(0xFF101830);

  final Paint _borderPaint = Paint()
    ..color = const Color(0xFF54F6FF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  final Paint _iconPaint = Paint()
    ..color = const Color(0xFF54F6FF)
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.round;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    position = Vector2(
      size.x -20,
      110,
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final rect = Rect.fromLTWH(
      0,
      0,
      size.x,
      size.y,
    );

    final roundedRect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(16),
    );

    canvas.drawRRect(roundedRect, _backgroundPaint);

    canvas.drawRRect(roundedRect, _borderPaint);

    canvas.drawLine(
      const Offset(20, 17),
      const Offset(20, 37),
      _iconPaint,
    );

    canvas.drawLine(
      const Offset(34, 17),
      const Offset(34, 37),
      _iconPaint,
    );
  }

  @override
  void onTapUp(TapUpEvent event) {
    onPause();
  }
}

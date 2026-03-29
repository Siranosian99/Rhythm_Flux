import 'package:flutter/material.dart';

class RestartButton extends StatelessWidget {
  final VoidCallback onPressed;
  const RestartButton({
    super.key,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
       onPressed;
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Color(0xFF6C63FF),
            width: 2,
          ),
        ),
      ),
      child: const Text(
        "RESTART",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          shadows: [
            Shadow(
              color: Color(0xFF3A86FF),
              blurRadius: 8,
            ),
          ],
        ),
      ),
    );
  }
}
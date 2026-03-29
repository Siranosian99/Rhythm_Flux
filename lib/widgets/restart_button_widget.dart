import 'package:flutter/material.dart';

class EButtons extends StatelessWidget {
  final VoidCallback onPressed;
  final  String buttonText;
  const EButtons({
    super.key,
    required this.onPressed,
    required this.buttonText
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:
       onPressed,
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
      child:  Text(
      buttonText,
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
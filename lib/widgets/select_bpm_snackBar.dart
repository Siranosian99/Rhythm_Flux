import  'package:flutter/material.dart';

void showBpmSnackBar(BuildContext context,String txt1,String txt2) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.music_note_rounded,
            color: Color(0xFFD7B8FF),
            size: 28,
          ),
          const SizedBox(width: 14),
           Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  txt1,
                  // 'Music rhythm required',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  txt2,
                  // 'Please select a music rhythm to play.',
                  style: TextStyle(
                    color: Color(0xFFD0C5E0),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF191326),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
      elevation: 0,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color(0xFF6946A5),
          width: 1,
        ),
      ),
    ),
  );
}
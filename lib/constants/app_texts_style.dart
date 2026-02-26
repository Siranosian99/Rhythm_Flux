import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle? appName1Style = GoogleFonts.pressStart2p(
    fontSize: 70,
    color: Colors.lightBlueAccent,
    shadows: [
      Shadow(blurRadius: 5, color: Colors.purpleAccent),
      Shadow(blurRadius: 15, color: Colors.purpleAccent),
      Shadow(blurRadius: 30, color: Colors.purpleAccent),
      Shadow(blurRadius: 60, color: Colors.purpleAccent.withOpacity(0.5)),
    ],
  );
  static TextStyle? appName2Style = GoogleFonts.pressStart2p(
    fontSize: 80,
    color: Colors.purpleAccent,
    shadows: [
      Shadow(blurRadius: 5, color: Colors.lightBlueAccent),
      Shadow(blurRadius: 15, color: Colors.lightBlueAccent),
      Shadow(blurRadius: 30, color: Colors.lightBlueAccent),
      Shadow(blurRadius: 60, color: Colors.lightBlueAccent.withOpacity(0.5)),
    ],
  );
}

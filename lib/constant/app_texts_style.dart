import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle appName1Style(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final scale = screenWidth / 375;

    return GoogleFonts.pressStart2p(
      fontSize: 55 * scale, // scale ile büyüklük ayarlanıyor
      color: Colors.lightBlueAccent,
      shadows: [
        Shadow(blurRadius: 5, color: Colors.purpleAccent),
        Shadow(blurRadius: 15, color: Colors.purpleAccent),
        Shadow(blurRadius: 30, color: Colors.purpleAccent),
        Shadow(blurRadius: 60, color: Colors.purpleAccent.withOpacity(0.5)),
      ],
    );
  }

  static TextStyle appName2Style(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;

    return GoogleFonts.pressStart2p(
      fontSize: 55 * scale,
      color: Colors.purpleAccent,
      shadows: [
        Shadow(blurRadius: 5, color: Colors.lightBlueAccent),
        Shadow(blurRadius: 15, color: Colors.lightBlueAccent),
        Shadow(blurRadius: 30, color: Colors.lightBlueAccent),
        Shadow(blurRadius: 60, color: Colors.lightBlueAccent.withOpacity(0.5)),
      ],
    );
  }
  static TextStyle startPlayStyle(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;
    return GoogleFonts.luckiestGuy(
      fontSize: 25 * scale,
      color: Colors.orange,
    );
  }
  static TextStyle songSelectTextStyle(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;
    return GoogleFonts.pixelifySans(
      fontSize: 20 * scale,
      color: Colors.yellow,
    );
  }
static TextStyle settingStyle=GoogleFonts.comicNeue(
  shadows: [
    Shadow(blurRadius: 5, color: Colors.purpleAccent),
    Shadow(blurRadius: 15, color: Colors.purpleAccent),
    Shadow(blurRadius: 1, color: Colors.purpleAccent),
    Shadow(blurRadius: 2, color: Colors.purpleAccent.withOpacity(0.5)),
  ]

);
  static TextStyle loginTextStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;

    return GoogleFonts.pressStart2p(
      fontSize: 30 * scale,
      color: Colors.purpleAccent,
      shadows: [
        Shadow(blurRadius: 5, color: Colors.lightBlueAccent),
        Shadow(blurRadius: 15, color: Colors.lightBlueAccent),
        Shadow(blurRadius: 30, color: Colors.lightBlueAccent),
        Shadow(blurRadius: 60, color: Colors.lightBlueAccent.withOpacity(0.5)),
      ],
    );
  }

}
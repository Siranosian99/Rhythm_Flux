import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:rhythm_flux/provider/audio_provider.dart';
import 'package:rhythm_flux/screens/main_menu_screen.dart';
import 'package:rhythm_flux/screens/play_screen.dart';
import 'package:rhythm_flux/screens/signup_screen.dart';
import 'package:rhythm_flux/screens/splash_screen.dart';

void main() {
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (_) => AudioProvider(),
  //     child: const MyApp(),
  //   ),
  // );
  runApp(const MyApp());
}

// git config --global user.email "aleppo.vs1@gmail.com"
// git config --global user.name "Siranosian99"

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rhythm Flux',
      theme: ThemeData(
        appBarTheme:AppBarThemeData(
          backgroundColor:Colors.black
        ),
        scaffoldBackgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:const SplashScreen()
    );
  }
}


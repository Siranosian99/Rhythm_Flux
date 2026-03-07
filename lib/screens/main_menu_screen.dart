import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:rhythm_flux/constants/app_texts_style.dart';
import 'package:rhythm_flux/screens/play_screen.dart';

import '../constants/app_texts.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomOffset = screenHeight * 0.3;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              //      - assets/lottie/equalizer_blue.json
              //       - assets/lottie/equalizer_pink.json
              //       - assets/lottie/video_play_button.json
              // Lottie.asset('assets/lottie/equalizer_blue.json'),
              // Lottie.asset('assets/lottie/equalizer_pink.json'),
              Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  Lottie.asset('assets/lottie/equalizer_pink.json'),
                  Text(
                    AppTexts.appName1,
                    style: AppTextStyles.appName1Style(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  Lottie.asset('assets/lottie/equalizer_blue.json'),
                  Text(
                    AppTexts.appName2,
                    style: AppTextStyles.appName2Style(context),

                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.rotate(
                    angle: 1.5, // radians cinsinden
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Lottie.asset(
                        "assets/lottie/music_notes_white.json",
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: -1.5, // radians cinsinden
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Lottie.asset(
                        "assets/lottie/music_notes_white.json",
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Lottie.asset("assets/lottie/happy_spaceman.json"),
                ),
              ),
              Text(AppTexts.startPlay,style:AppTextStyles.startPlayStyle(context),),
              SizedBox(
                width: bottomOffset,
                height: bottomOffset,
                child: GestureDetector(
                  onTap: () async{
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => const PlayScreen(),
                    //   ),
                    // );
                    final player = AudioPlayer();                   // Create a player
                    final duration = await player.setAsset(           // Load a URL
                        'assets/music/music_example.mp3');                 // Schemes: (https: | file: | asset: )
                    player.play();                                  // Play without waiting for completion
                    // await player.play();
                  },
                  child: Lottie.asset('assets/lottie/play_button.json'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){}, child: Text(AppTexts.settings,style:AppTextStyles.settingStyle,)),
                  TextButton(onPressed: (){}, child: Text(AppTexts.scores,style:AppTextStyles.settingStyle,)),                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

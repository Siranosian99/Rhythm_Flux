import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:rhythm_flux/screens/play_screen.dart';
import 'package:rhythm_flux/utils/file_picker.dart';

import '../constant/app_texts.dart';
import '../constant/app_texts_style.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>
    with TickerProviderStateMixin {
  late final player;
  late final AnimationController _controller;
  bool isAblePlay = false;

  @override
  void initState() {
    super.initState();
    isMusicPlaying();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    player.dispose();
    super.dispose();
  }

  void isMusicPlaying() async {
    player = AudioPlayer();
    await player.setAsset('assets/audio/old_sega.mp3');
    await player.setLoopMode(LoopMode.one);

    player.play();
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
                    angle: 1.5,
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Lottie.asset(
                        "assets/lottie/music_notes_white.json",
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: -1.5,
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
              SizedBox(
                  height: 200,
                  width: 200,
                  child: Lottie.asset("assets/lottie/happy_spaceman.json"),
                ),
              Text(
                AppTexts.startPlay,
                style: AppTextStyles.startPlayStyle(context),
              ),
              TextButton(
                onPressed: () async {
                  await FilePickerHelper.selectFile();
                },
                child: Text(
                  AppTexts.selectMusic,
                  style: AppTextStyles.songSelectTextStyle(context),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: bottomOffset,
                  height: bottomOffset,
                  child: GestureDetector(
                    onTap: //isaAblePlay
                    true
                        ? () async {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PlayScreen(),
                              ),
                            );
                            player.dispose();
                          }
                        : null,
                    child: Lottie.asset('assets/lottie/play_button.json'),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppTexts.settings,
                      style: AppTextStyles.settingStyle,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppTexts.scores,
                      style: AppTextStyles.settingStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

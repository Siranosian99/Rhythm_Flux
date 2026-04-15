import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:rhythm_flux/screens/play_screen.dart';
import 'package:rhythm_flux/screens/previous_rhythms.dart';
import 'package:rhythm_flux/service/models/score_model.dart';
import 'package:rhythm_flux/service/music_analyze/analyze_service.dart';
import 'package:rhythm_flux/service/user_service/users.dart';
import 'package:rhythm_flux/utils/file_picker.dart';
import 'package:rhythm_flux/utils/token_helper.dart';
import 'package:rhythm_flux/widgets/settings_dialog.dart';
import 'package:rhythm_flux/widgets/score_dialog.dart';

import '../constant/app_texts.dart';
import '../constant/app_texts_style.dart';
import '../provider/audio_provider.dart';
import '../utils/audio_manager.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late final _userService;
  late final AnimationController _controller;
  bool isAblePlay = false;
  bool isMute=false;
  double volume = 0.5;
  List<int> allScores = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _userService = UserService();
    AudioManager.isMusicPlaying("old_sega");
    getScores();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    // AudioManager.pause();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AudioManager.resume();
    } else if (state == AppLifecycleState.paused) {
      AudioManager.pause();
    }
  }

  Future<void> getToken() async {
    await _userService.getUser();
  }

  Future<void> getScores() async {
    allScores = await _userService.getScores();
    // allScores = data.map((e) => e as int).toList();
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
                  // final token = await TokenHelper().tokenLocalGetter();
                  // print("ttt--------------$token");
                  await getToken();
                  FilePickerHelper.selectFile();
                  // final formData = await FilePickerHelper.selectFile();
                  // if (!context.mounted) return;
                  // if (formData == null) return;
                  // final audioData = await analyzer.analyzer(formData);
                  // if (!context.mounted) return;
                  // context.read<AudioProvider>().setAudio(audioData!);
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
                            AudioManager.pause();
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
                    onPressed: () async {
                      await settingsDialog(context, (value) {
                        setState(() {
                          volume = value;
                        });

                        AudioManager.setVol(value);
                      }, volume,isMute,(value){
                        setState(() {
                          isMute=value;
                        });
                       isMute ? AudioManager.mute(): AudioManager.unMute(volume);
                      });
                    },
                    child: Text(
                      AppTexts.settings,
                      style: AppTextStyles.settingStyle,
                    ),
                  ),

                  TextButton(
                    onPressed: () async {
                      AudioManager.pause();
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RhythmListScreen()),
                      );
                      AudioManager.resume();
                    },
                    child: Text(
                      AppTexts.previous,
                      style: AppTextStyles.settingStyle,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await scoreDialog(context, allScores);
                    },
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

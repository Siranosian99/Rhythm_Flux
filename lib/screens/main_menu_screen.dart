import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rhythm_flux/features/score/score_cubit.dart';
import 'package:rhythm_flux/screens/bpm_screen.dart';
import 'package:rhythm_flux/screens/play_screen.dart';
import 'package:rhythm_flux/screens/previous_rhythms.dart';
import 'package:rhythm_flux/utils/file_picker.dart';
import 'package:rhythm_flux/widgets/settings_dialog.dart';
import 'package:rhythm_flux/widgets/score_dialog.dart';
import '../core/constant/app_texts.dart';
import '../core/constant/app_texts_style.dart';
import '../features/user/user_cubit.dart';
import '../service/bpm_saver/bpm_local_saver.dart';
import '../utils/audio_manager.dart';
import '../widgets/select_bpm_snackBar.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>
    with WidgetsBindingObserver {
  // late final AnimationController _controller;
  bool isMute = false;
  double volume = 0.5;
  List<int> allScores = [];
  final BpmLocalHelper _bpmLocalHelper = BpmLocalHelper();
  double? bpm;
  bool isReady = false;
  double beatDuration = 0;

  Future<void> _initializeBpm() async {
    await _bpmLocalHelper.init();
    await _loadBpm();
  }

  Future<void> _loadBpm() async {
    final savedBpm = _bpmLocalHelper.getBpm();

    if (!mounted) return;

    setState(() {
      if (savedBpm <= 0) {
        isReady = false;
        bpm = null;
        beatDuration = 0;
      } else {
        bpm = savedBpm;
        beatDuration = 60 / savedBpm;
        isReady = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getScores();
    _initializeBpm();

    AudioManager.playMusic("old_sega");
    // _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // _controller.dispose();
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

  Future<void> _getScores() async {
    await context.read<ScoreCubit>().getScores();
  }

  // Future<void> _getScores() async {
  //   await context.read<UserCubit>().getUser();
  //   if(!mounted) return;
  //   final scores = await context.read<ScoreCubit>().getScores() ?? [];
  //   if(!mounted) return;
  //   setState(() {
  //     allScores =scores;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final playButtonSize = screenHeight * 0.3;
    return Scaffold(
      body: SafeArea(
        child: Center(child: _mainMenuColumn(context, playButtonSize)),
      ),
    );
  }

  Column _mainMenuColumn(BuildContext context, double bottomOffset) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Lottie.asset('${AppTexts.assets}/equalizer_pink.json'),
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
            Lottie.asset('${AppTexts.assets}/equalizer_blue.json'),
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
                  "${AppTexts.assets}/music_notes_white.json",
                ),
              ),
            ),
            Transform.rotate(
              angle: -1.5,
              child: SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset(
                  "${AppTexts.assets}/music_notes_white.json",
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 200,
          width: 200,
          child: Lottie.asset("${AppTexts.assets}/happy_spaceman.json"),
        ),
        Text(AppTexts.startPlay, style: AppTextStyles.startPlayStyle(context)),
        TextButton(
          onPressed: () async {
            await context.read<UserCubit>().getUser();
            await FilePickerHelper.selectFile();
          },

          child: Text(
            AppTexts.selectMusic,
            style: AppTextStyles.songSelectTextStyle(context),
          ),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BpmScreen()),
            );
          },
          child: Text(
            AppTexts.selectBpm,
            style: AppTextStyles.songSelectTextStyle(context),
          ),
        ),

        Expanded(
          child: SizedBox(
            width: bottomOffset,
            height: bottomOffset,
            child: GestureDetector(
              onTap: isReady
                  ? () async {
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) =>  PlayScreen()),
                      );
                      await AudioManager.pause();
                    }
                  : (){
                showBpmSnackBar(context);
              },
              child: Lottie.asset('${AppTexts.assets}/play_button.json'),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                settingsDialog(
                  context,
                  (value) {
                    setState(() {
                      volume = value;
                    });

                    AudioManager.setVolume(value);
                  },
                  volume,
                  isMute,
                  (value) {
                    setState(() {
                      isMute = value;
                    });
                    isMute
                        ? AudioManager.mute()
                        : AudioManager.setVolume(volume);
                  },
                  () {
                    SystemNavigator.pop();
                  },
                );
              },
              child: Text(AppTexts.settings, style: AppTextStyles.settingStyle),
            ),

            TextButton(
              onPressed: () async {
                AudioManager.pause();
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RhythmListScreen()),
                );
                await _loadBpm();
              },
              child: Text(AppTexts.previous, style: AppTextStyles.settingStyle),
            ),
            TextButton(
              onPressed: () {
                final scores = context.read<ScoreCubit>().state.scores;
                allScores=scores;
                scoreDialog(context, allScores);
              },
              child: Text(AppTexts.scores, style: AppTextStyles.settingStyle),
            ),
          ],
        ),
      ],
    );
  }
}

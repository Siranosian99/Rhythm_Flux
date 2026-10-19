import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rhythm_flux/core/network/dio_client.dart';
import 'package:rhythm_flux/features/score/score_cubit.dart';
import 'package:rhythm_flux/features/score/score_repository.dart';
import 'package:rhythm_flux/screens/main_menu_screen.dart';
import 'package:rhythm_flux/widgets/game_over_widget.dart';
import 'package:rhythm_flux/game/game_screen.dart';

import '../core/constant/app_texts.dart';

class PlayScreen extends StatelessWidget {
   PlayScreen({super.key});
final DioClient _dioClient=DioClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: MyGame(
          onExit: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainMenuScreen()),
            );
            // Navigator.pop(context);
          },
          scoreCubit: ScoreCubit(
            repository: ScoreRepository(dio: _dioClient.dio, tokenHelper: _dioClient.tokenHelper),
          ),
        ),
        overlayBuilderMap: {
          AppTexts.gameOver2: (context, game) {
            return GameOverOverlay(game: game as MyGame);
          },
          'PauseMenu': (context, game) {
            return const Center(
              child: Text(
                'PAUSED',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            );
          },
        },
      ),
    );
  }
}

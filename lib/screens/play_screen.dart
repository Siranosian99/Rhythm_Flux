import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rhythm_flux/widgets/game_over_widget.dart';
import 'package:rhythm_flux/game/game_screen.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: MyGame(
          onExit:(){
            Navigator.pop(context);
          }
        ),
        overlayBuilderMap: {
          'GameOver': (context,game) {
            return GameOverOverlay(game:game as MyGame);
          },

        },
      ),
    );
  }
}

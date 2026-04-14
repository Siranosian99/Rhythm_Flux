import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:rhythm_flux/game/player.dart';
//
// import 'game_screen.dart';
//
// class ScoreZone extends PositionComponent
//     with CollisionCallbacks, HasGameRef<MyGame> {
//
//   bool counted = false;
//   double? entryY; // nereden girdi
//
//   final Player player;
//
//   ScoreZone(this.player)
//       : super(
//     size: Vector2(100, 500),
//     position: Vector2(200, 200),
//   );
//
//   @override
//   Future<void> onLoad() async {
//     add(RectangleHitbox(collisionType: CollisionType.passive));
//   }
//
//   // 👉 ZONE’A GİRİNCE
//   @override
//   void onCollisionStart(Set<Vector2> _, PositionComponent other) {
//     if (other is Player && !counted) {
//       entryY = player.y; // giriş noktası
//     }
//   }
//
//   // 👉 ZONE’DAN ÇIKINCA
//   @override
//   void onCollisionEnd(PositionComponent other) {
//     if (other is Player && !counted && entryY != null) {
//       final exitY = player.y;
//
//       final enteredFromTop = entryY! < y;
//       final enteredFromBottom = entryY! > y + height;
//
//       final exitedOpposite =
//           (enteredFromTop && exitY > y + height) ||
//               (enteredFromBottom && exitY < y);
//
//       if (exitedOpposite) {
//         counted = true;
//         gameRef.state.addScore();
//         print("SCORE +1 ✅");
//       }
//     }
//   }
// }
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Fake audio player (gerçek player yerine simülasyon)
class FakePlayer {
  double volume = 0.5;

  void setVolume(double v) {
    volume = v;
    print("Volume set to: $volume");
  }
}

final player = FakePlayer();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double volume = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Volume Control"),
        backgroundColor: Colors.purple,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "VOLUME",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 20),

            Slider(
              value: volume,
              min: 0.0,
              max: 1.0,
              activeColor: Colors.purpleAccent,
              inactiveColor: Colors.grey,

              onChanged: (value) {
                setState(() {
                  volume = value;
                });

                player.setVolume(value);
              },
            ),

            Text(
              volume.toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
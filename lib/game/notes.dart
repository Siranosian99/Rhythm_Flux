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
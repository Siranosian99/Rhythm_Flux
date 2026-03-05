// /*
// 1-make pages design
// 2-think about game logic
// 3- start make the backend Data wich must save score name and musics
// 4-how to get the glasses with rhytms
// 5-how does connect the logic with UI and backend
//
// pray for me
//
// * */
//
//
//
//
// import 'dart:async';
// import 'package:flutter/material.dart';
//
// void main() => runApp(MaterialApp(home: Scaffold(body: RhythmDoorUI())));
//
// class RhythmDoorUI extends StatefulWidget {
//   @override
//   _RhythmDoorUIState createState() => _RhythmDoorUIState();
// }
//
// class _RhythmDoorUIState extends State<RhythmDoorUI> {
//   double openAmount = 0; // 0 = kapalı, 1 = tam açık
//   bool opening = true;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Timer ile ritim simülasyonu
//     _timer = Timer.periodic(Duration(milliseconds: 50), (_) {
//       setState(() {
//         if (opening) {
//           openAmount += 0.05;
//           if (openAmount >= 1) opening = false;
//         } else {
//           openAmount -= 0.05;
//           if (openAmount <= 0) opening = true;
//         }
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double panelWidth = 60;
//     double spacing = openAmount * 60; // açılma mesafesi
//
//     // Ekran ortasını sabit değer ile simüle ediyoruz
//     double centerX = 200;
//
//     return Container(
//       color: Colors.black,
//       child: Center(
//         child: Stack(
//           children: [
//             // Sol panel
//             Positioned(
//               left: centerX - panelWidth - spacing / 2,
//               top: 100,
//               child: Container(
//                 width: panelWidth,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   color: Colors.cyanAccent,
//                   borderRadius: BorderRadius.circular(4),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.cyanAccent.withOpacity(0.6),
//                         blurRadius: 12,
//                         spreadRadius: 2)
//                   ],
//                 ),
//               ),
//             ),
//             // Sağ panel
//             Positioned(
//               left: centerX + spacing / 2,
//               top: 100,
//               child: Container(
//                 width: panelWidth,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   color: Colors.cyanAccent,
//                   borderRadius: BorderRadius.circular(4),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.cyanAccent.withOpacity(0.6),
//                         blurRadius: 12,
//                         spreadRadius: 2)
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

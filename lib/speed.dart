// class RhythmSpeedCalculator {
//   // ============================================================
//   // GAME SETTINGS
//   // ============================================================
//
//   // Bir normal beat süresinde kapının ilerlemesini
//   // istediğimiz mesafe.
//   static const double doorDistancePerBeat = 150.0;
//
//   // Ritim multiplier sınırları.
//   static const double minRhythmMultiplier = 0.80;
//   static const double maxRhythmMultiplier = 1.20;
//
//   // Kapının minimum ve maksimum hızı.
//   static const double minSpeed = 220.0;
//   static const double maxSpeed = 380.0;
//
//   // Ortalama hesaplarken kaç son interval kullanılacak.
//   static const int intervalWindow = 4;
//
//
//   // ============================================================
//   // MAIN CALCULATION
//   // ============================================================
//
//   static double calculateSpeed({
//     required double bpm,
//     required List<double> beats,
//   }) {
//     // ----------------------------------------------------------
//     // 1. BPM → Normal beat interval
//     // ----------------------------------------------------------
//
//     final double normalBeatInterval = 60.0 / bpm;
//
//
//     // ----------------------------------------------------------
//     // 2. BPM → Base speed
//     // ----------------------------------------------------------
//
//     final double baseSpeed =
//         doorDistancePerBeat / normalBeatInterval;
//
//
//     // ----------------------------------------------------------
//     // 3. Beat timestamps → Beat intervals
//     // ----------------------------------------------------------
//
//     final List<double> beatIntervals = [];
//
//     for (int i = 1; i < beats.length; i++) {
//       final double interval =
//           beats[i] - beats[i - 1];
//
//       beatIntervals.add(interval);
//     }
//
//
//     // ----------------------------------------------------------
//     // 4. Son interval'ları al
//     // ----------------------------------------------------------
//
//     final int startIndex =
//     beatIntervals.length > intervalWindow
//         ? beatIntervals.length - intervalWindow
//         : 0;
//
//     final List<double> recentIntervals =
//     beatIntervals.sublist(startIndex);
//
//
//     // ----------------------------------------------------------
//     // 5. Average beat interval
//     // ----------------------------------------------------------
//
//     final double averageBeatInterval =
//         recentIntervals.reduce((a, b) => a + b) /
//             recentIntervals.length;
//
//
//     // ----------------------------------------------------------
//     // 6. Rhythm multiplier
//     // ----------------------------------------------------------
//
//     final double rhythmMultiplier =
//         normalBeatInterval / averageBeatInterval;
//
//
//     // ----------------------------------------------------------
//     // 7. Rhythm multiplier sınırla
//     // ----------------------------------------------------------
//
//     final double clampedRhythmMultiplier =
//     rhythmMultiplier.clamp(
//       minRhythmMultiplier,
//       maxRhythmMultiplier,
//     );
//
//
//     // ----------------------------------------------------------
//     // 8. Base speed × rhythm multiplier
//     // ----------------------------------------------------------
//
//     final double targetSpeed =
//         baseSpeed * clampedRhythmMultiplier;
//
//
//     // ----------------------------------------------------------
//     // 9. Final speed sınırı
//     // ----------------------------------------------------------
//
//     final double finalSpeed =
//     targetSpeed.clamp(
//       minSpeed,
//       maxSpeed,
//     );
//
//
//     return finalSpeed;
//   }
// }
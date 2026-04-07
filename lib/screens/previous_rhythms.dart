import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Rhythm {
  final String songName;
  final int bpm;
  final List<int> beats;

  Rhythm({
    required this.songName,
    required this.bpm,
    required this.beats,
  });
}

class RhythmListScreen extends StatelessWidget {
  final List<Rhythm> rhythms = [
    Rhythm(songName: "Cyber Beat", bpm: 120, beats: [1, 0, 1, 1, 0]),
    Rhythm(songName: "Neon Pulse", bpm: 140, beats: [1, 1, 0, 1, 0, 1]),
    Rhythm(songName: "Pixel Rhythm", bpm: 100, beats: [1, 0, 0, 1]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Rhythms",
          style: GoogleFonts.pressStart2p(
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: rhythms.length,
        itemBuilder: (context, index) {
          final rhythm = rhythms[index];

          return Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade900,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.blueAccent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.5),
                  blurRadius: 10,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🎵 Song Name
                Text(
                  rhythm.songName,
                  style: GoogleFonts.pressStart2p(
                    fontSize: 14,
                    color: Colors.blueAccent,
                  ),
                ),

                const SizedBox(height: 12),

                /// 🔥 BPM
                Text(
                  "BPM: ${rhythm.bpm}",
                  style: GoogleFonts.pressStart2p(
                    fontSize: 12,
                    color: Colors.purpleAccent,
                  ),
                ),

                const SizedBox(height: 12),

                /// 🎯 Beats List
                Wrap(
                  spacing: 8,
                  children: rhythm.beats.map((beat) {
                    return Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: beat == 1
                            ? Colors.blueAccent
                            : Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
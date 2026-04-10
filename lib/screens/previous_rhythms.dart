import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythm_flux/constant/app_texts.dart';
import 'package:rhythm_flux/service/models/audio_model.dart';
import 'package:rhythm_flux/service/music_analyze/analyze_service.dart';

import '../service/user_service/users.dart';

class RhythmListScreen extends StatefulWidget {
  @override
  State<RhythmListScreen> createState() => _RhythmListScreenState();
}

class _RhythmListScreenState extends State<RhythmListScreen> {
  late Analyzer _analyzer;
  late List<AudioData> rhythms = [];
  late final UserService _userService;

  @override
  void initState() {
    super.initState();
    _userService = UserService();
    _analyzer = Analyzer();
    Rhythms();
  }

  Future<void> Rhythms() async {
    await _userService.getUser();

    rhythms = await _analyzer.getUserRhythms() ?? [];
    setState(() {
      rhythms;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          AppTexts.rhythms,
          style: GoogleFonts.pressStart2p(fontSize: 16),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      body: rhythms.isEmpty
          ? Center(
              child: Text(
                AppTexts.oops,
                style: GoogleFonts.pressStart2p(
                  fontSize: 14,
                  color: Colors.purpleAccent,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: rhythms.length,
              itemBuilder: (context, index) {
                final rhythm = rhythms[index];

                return Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade900,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blueAccent, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rhythm.name,
                        style: GoogleFonts.pressStart2p(
                          fontSize: 14,
                          color: Colors.blueAccent,
                        ),
                      ),

                      const SizedBox(height: 12),
                      Text(
                        "BPM: ${rhythm.bpm}",
                        style: GoogleFonts.pressStart2p(
                          fontSize: 12,
                          color: Colors.purpleAccent,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// 🎯 Beats Visual Timeline
                      Wrap(
                        spacing: 6,
                        children: List.generate(rhythm.beats.length, (i) {
                          double diff = i == 0
                              ? 0
                              : rhythm.beats[i] - rhythm.beats[i - 1];

                          double intensity = (1 / (diff + 0.1)).clamp(0.3, 1.0);

                          Color color;
                          if (diff < 0.4) {
                            color = Colors.purpleAccent;
                          } else {
                            color = Colors.blueAccent;
                          }

                          return Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: color.withOpacity(intensity),
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: [
                                BoxShadow(
                                  color: color.withOpacity(intensity * 0.6),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

//beats = [0.5, 1.0, 1.8, 2.0]

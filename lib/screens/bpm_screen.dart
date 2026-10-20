import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythm_flux/core/constant/app_texts.dart';
import 'package:rhythm_flux/widgets/select_bpm_snackBar.dart';
import '../service/bpm_saver/bpm_local_saver.dart';
import 'main_menu_screen.dart';

class BpmScreen extends StatefulWidget {
  const BpmScreen({super.key});

  @override
  State<BpmScreen> createState() => _BpmScreenState();
}

class _BpmScreenState extends State<BpmScreen> {
  final BpmLocalHelper bpmHelper = BpmLocalHelper();

  double bpm = 120;
  bool isLoading = true;
  bool isSaving = false;

  static const Color background = Color(0xFF080D20);
  static const Color panel = Color(0xFF101830);
  static const Color neon = Color(0xFF54F6FF);
  static const Color purple = Color(0xFF9B6DFF);

  @override
  void initState() {
    super.initState();
    loadBpm();
  }

  Future<void> loadBpm() async {
    await bpmHelper.init();

    if (!mounted) return;

    setState(() {
      bpm = bpmHelper.getBpm().clamp(40, 240.0);
      isLoading = false;
    });
  }

  void changeBpm(double value) {
    setState(() {
      bpm = value.clamp(40, 500);
    });
  }

  Future<void> saveBpm() async {
    if (isSaving) return;
    setState(() {
      isSaving = true;
    });
    try {
      await bpmHelper.saveBpm(bpm);
      if (!mounted) return;
    showBpmSnackBar(context, AppTexts.isBpmSaved1, AppTexts.isBpmSaved2);
    } catch (e) {
      if (!mounted) return;
      showBpmSnackBar(context, AppTexts.isBpmFailed1 , AppTexts.isBpmFailed2 );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainMenuScreen()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        backgroundColor: background,
        foregroundColor: neon,
        elevation: 0,
        title: Text(
          'RHYTHM FLUX',
          style: GoogleFonts.orbitron(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: neon))
          : SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 440),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: panel,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: neon.withValues(alpha: 0.65)),
                      boxShadow: [
                        BoxShadow(
                          color: neon.withValues(alpha: 0.08),
                          blurRadius: 24,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.graphic_eq_rounded,
                          color: neon,
                          size: 48,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'BPM SETTINGS',
                          style: GoogleFonts.orbitron(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 32),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: neon.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '$bpm',
                                style: GoogleFonts.orbitron(
                                  color: neon,
                                  fontSize: 56,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'BEATS PER MINUTE',
                                style: GoogleFonts.orbitron(
                                  color: Colors.white70,
                                  fontSize: 10,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _adjustButton(
                              icon: Icons.remove_rounded,
                              onTap: () => changeBpm(bpm - 1),
                            ),
                            const SizedBox(width: 28),
                            _adjustButton(
                              icon: Icons.add_rounded,
                              onTap: () => changeBpm(bpm + 1),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: neon,
                            inactiveTrackColor: Colors.white12,
                            thumbColor: neon,
                            overlayColor: neon.withValues(alpha: 0.15),
                            trackHeight: 4,
                          ),
                          child: Slider(
                            min: 40.0,
                            max: 500.0,
                            divisions: 460,
                            value: bpm.clamp(40.0, 500.0),
                            onChanged: changeBpm,
                          ),
                        ),

                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '40 BPM',
                              style: TextStyle(color: Colors.white54),
                            ),
                            Text(
                              '500 BPM',
                              style: TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          children: [80, 100, 120, 140, 160, 180]
                              .map(
                                (value) => ChoiceChip(
                                  label: Text('$value'),
                                  selected: bpm == value,
                                  onSelected: (_) =>
                                      changeBpm(value.toDouble()),
                                  selectedColor: neon,
                                  backgroundColor: background,
                                  labelStyle: TextStyle(
                                    color: bpm == value
                                        ? background
                                        : Colors.white70,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  side: BorderSide(
                                    color: bpm == value ? neon : Colors.white24,
                                  ),
                                ),
                              )
                              .toList(),
                        ),

                        const SizedBox(height: 32),

                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton.icon(
                            onPressed: isSaving ? null:saveBpm,
                            icon: const Icon(Icons.save_rounded),
                            label: Text(
                              isSaving ? 'SAVING...' : 'SAVE BPM',
                              style: GoogleFonts.orbitron(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: neon,
                              foregroundColor: background,
                              disabledBackgroundColor: Colors.white24,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _adjustButton({required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 58,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: purple),
          ),
          child: Icon(icon, color: neon, size: 30),
        ),
      ),
    );
  }
}

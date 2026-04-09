class AudioData {
  final String name;
  final double bpm;
  final List<double> beats;

  AudioData({
    required this.name,
    required this.bpm,
    required this.beats,
  });

  @override
  String toString() {
    return 'AudioData(bpm: $bpm, beats: $beats)';
  }
}
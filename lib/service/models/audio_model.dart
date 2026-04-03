class AudioData {
  final double bpm;
  final List<double> beats;

  AudioData({
    required this.bpm,
    required this.beats,
  });

  @override
  String toString() {
    return 'AudioData(bpm: $bpm, beats: $beats)';
  }
}
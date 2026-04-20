import 'dart:math';

import 'package:rhythm_flux/utils/suprises.dart';

final _random = Random();

extension RandomSurprise on List<Surprise> {
  void triggerRandom() {
    if (isEmpty) return;

    final selected = this[_random.nextInt(length)];
    print("RunTIME:-------${selected.runtimeType}");

    selected.surprise();
  }
}
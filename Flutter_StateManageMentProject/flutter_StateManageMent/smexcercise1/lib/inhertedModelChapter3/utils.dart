import 'dart:math' show Random;

import 'package:flutter/material.dart';

enum AvailableColors { one, two }

final colors = [
  Colors.black,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.purple,
  Colors.teal,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        Random().nextInt(length),
      );
}

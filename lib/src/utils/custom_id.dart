import 'dart:math';

import '../extensions/extension.dart';

String generateCustomId() {
  final value = Random().nextString(6);
  final result = '${value.substring(0, 3)}-${value.substring(3, 6)}';
  return result;
}

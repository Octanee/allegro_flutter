import 'dart:math';

extension RandomString on Random {
  String nextString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    return String.fromCharCodes(
      List.generate(length, (index) => chars.codeUnitAt(nextInt(chars.length))),
    );
  }
}

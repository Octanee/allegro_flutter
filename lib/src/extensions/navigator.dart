import 'package:flutter/cupertino.dart';

extension NavigatorExtension on BuildContext {
  NavigatorState get navigator => Navigator.of(this);
}

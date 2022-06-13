import 'package:intl/intl.dart';

extension BetterDateFormat on DateTime {

  String toFormatedString() {
    final format = DateFormat('EEE, HH:mm M/d/y');
    return format.format(this);
  }
}

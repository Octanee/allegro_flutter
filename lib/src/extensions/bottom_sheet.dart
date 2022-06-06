import 'package:flutter/material.dart';

extension BottomSheetExtension on BuildContext {
  void showBottomSheet({required Widget Function(BuildContext) builder}) =>
      showModalBottomSheet(
        isScrollControlled: true,
        context: this,
        builder: builder,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      );
}

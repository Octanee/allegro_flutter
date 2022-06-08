import 'package:flutter/material.dart';

extension BottomSheetExtension on BuildContext {
  Future<T?> showBottomSheet<T>({
    required Widget Function(BuildContext) builder,
  }) async =>
      await showModalBottomSheet(
        isScrollControlled: true,
        context: this,
        builder: builder,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      );
}

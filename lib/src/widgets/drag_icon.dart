import 'package:flutter/material.dart';

class DragIcon extends StatelessWidget {
  const DragIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [Icon(Icons.drag_handle_rounded)],
    );
  }
}

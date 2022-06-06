import 'package:flutter/material.dart';

import '../../../../../extensions/extension.dart';

class AddToOrder extends StatelessWidget {
  const AddToOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Icon(Icons.drag_handle_rounded)],
        ),
        ElevatedButton(
          onPressed: () {
            context.navigator.pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

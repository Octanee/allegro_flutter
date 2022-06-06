import 'package:flutter/material.dart';

import '../../../../../extensions/extension.dart';
import 'widget.dart';

class AddToOrderFab extends StatelessWidget {
  const AddToOrderFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        //TODO Add to order
        context.showBottomSheet(
          builder: (context) => const AddToOrder(),
        );
      },
      child: const Icon(Icons.shopping_bag_rounded),
    );
  }
}

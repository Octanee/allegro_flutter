import 'package:flutter/material.dart';

import '../extensions/extension.dart';
import 'widgets.dart';

class AddSubtractCard extends StatelessWidget {
  final String title;
  final int value;
  final int minValue;
  final int maxValue;

  final void Function()? onAdd;
  final void Function()? onSubtract;
  final void Function()? onTap;

  const AddSubtractCard({
    required this.title,
    required this.value,
    this.maxValue = 99,
    this.minValue = 0,
    this.onAdd,
    this.onSubtract,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickableCard(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _subtractButton(),
          _value(context),
          _addButton(),
        ],
      ),
    );
  }

  Widget _value(BuildContext context) {
    return Text(
      value.toString(),
      style: context.titleLargePrimary,
    );
  }

  Widget _addButton() {
    return ElevatedButton(
      onPressed: value < maxValue ? onAdd : null,
      child: const Icon(Icons.add),
    );
  }

  Widget _subtractButton() {
    return ElevatedButton(
      onPressed: value > minValue ? onSubtract : null,
      child: const Icon(Icons.remove),
    );
  }
}

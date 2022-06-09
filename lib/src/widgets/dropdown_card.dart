import 'package:flutter/material.dart';

import '../extensions/extension.dart';

class DropdownCard<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String title;
  final EdgeInsets padding;
  final T value;

  const DropdownCard({
    required this.items,
    required this.title,
    required this.value,
    this.padding = EdgeInsets.zero,
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.labelMedium),
            DropdownButton<T>(
              value: value,
              isDense: true,
              isExpanded: true,
              items: items,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

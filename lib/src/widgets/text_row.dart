import 'package:flutter/material.dart';

import '../extensions/extension.dart';

class TextRow extends StatelessWidget {
  final String name;
  final String value;
  final bool isPrice;
  final MainAxisAlignment alignment;

  const TextRow({
    required this.name,
    required this.value,
    this.alignment = MainAxisAlignment.spaceBetween,
    this.isPrice = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        Flexible(child: Text('$name:')),
        Flexible(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                value,
                style: context.bodyLarge,
              ),
              Visibility(
                visible: isPrice,
                child: Text(
                  'PLN',
                  style: context.labelMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

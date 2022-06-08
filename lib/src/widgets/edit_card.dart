import 'package:flutter/material.dart';

import '../extensions/extension.dart';
import 'clickable_card.dart';

class EditCard extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final String value;
  final bool isValid;

  const EditCard({
    required this.onTap,
    required this.title,
    required this.value,
    this.isValid = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickableCard(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.labelMedium,
              ),
              Text(
                value,
                style: context.titleLargePrimary,
              ),
            ],
          ),
          const SizedBox(width: 16),
          Icon(
            Icons.edit,
            color: isValid ? context.colors.primary : context.colors.error,
          ),
        ],
      ),
    );
  }
}

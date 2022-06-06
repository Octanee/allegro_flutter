import 'package:flutter/material.dart';

import '../extensions/extension.dart';

class ClickableCard extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;

  const ClickableCard({
    required this.child,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(context.paddingMedium),
          child: child,
        ),
      ),
    );
  }
}

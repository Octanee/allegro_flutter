import 'package:flutter/material.dart';

class RowButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final EdgeInsets padding;

  const RowButton({
    required this.child,
    this.padding = EdgeInsets.zero,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: padding,
            child: ElevatedButton(
              onPressed: onPressed,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}

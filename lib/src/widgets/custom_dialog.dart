import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String text;
  final String cancelButtonText;
  final String acceptButtonText;

  const CustomDialog({
    required this.title,
    required this.text,
    this.cancelButtonText = 'CANCEL',
    this.acceptButtonText = 'ACCEPT',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(cancelButtonText),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(acceptButtonText),
        ),
      ],
    );
  }
}

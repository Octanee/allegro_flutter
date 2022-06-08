import 'package:flutter/material.dart';

class NumberInputDialog extends StatelessWidget {
  final String title;
  final String cancelButtonText;
  final String acceptButtonText;
  final double initValue;

  const NumberInputDialog({
    required this.title,
    this.cancelButtonText = 'CANCEL',
    this.acceptButtonText = 'ACCEPT',
    this.initValue = 0.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text: initValue.toString(),
    );

    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: Text(cancelButtonText),
        ),
        ElevatedButton(
          onPressed: () {
            final text = controller.text;
            final value = text.isNotEmpty ? double.parse(text) : null;
            Navigator.pop(context, value);
          },
          child: Text(acceptButtonText),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../extensions/extension.dart';
import '../../../sign_up/sign_up.dart';

class SignUpButton extends StatelessWidget {
  final EdgeInsets padding;
  const SignUpButton({required this.padding, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('loginForm_signUpButton'),
      onPressed: () => Navigator.of(context).push(SignUpPage.route()),
      child: Padding(
        padding: padding,
        child: Text(
          'CREATE ACCOUNT',
          style: context.titleMedium?.copyWith(
            color: context.colors.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

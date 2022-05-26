import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../extensions/extension.dart';
import '../../login.dart';

class LoginButton extends StatelessWidget {
  final EdgeInsets padding;
  const LoginButton({required this.padding, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: state.status.isValidated ? onPressed : null,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.paddingLarge),
                  child: Text(
                    'LOGIN',
                    style: context.titleLarge
                        ?.copyWith(color: context.colors.primary),
                  ),
                ),
              );
      },
    );
  }

  void onPressed() {}
}

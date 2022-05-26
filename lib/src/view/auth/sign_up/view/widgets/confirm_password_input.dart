import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../sign_up.dart';

class ConfirmPasswordInput extends StatelessWidget {
  final EdgeInsets padding;
  const ConfirmPasswordInput({required this.padding, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) =>
            previous.password != current.password ||
            previous.confirmedPassword != current.confirmedPassword,
        builder: (context, state) {
          return TextField(
            key: const Key('signUpForm_confirmPasswordInput'),
            obscureText: true,
            onChanged: (confirmedPassword) => context
                .read<SignUpCubit>()
                .confirmedPasswordChanged(value: confirmedPassword),
            decoration: InputDecoration(
              labelText: 'Confirmed password',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  // TODO Hide/Show password
                },
              ),
              errorText: state.errorMessage,
            ),
          );
        },
      ),
    );
  }
}

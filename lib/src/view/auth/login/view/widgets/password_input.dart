import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login.dart';

class PasswordInput extends StatelessWidget {
  final EdgeInsets padding;
  const PasswordInput({required this.padding, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_passwordInput'),
            obscureText: true,
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(value: password),
            decoration: InputDecoration(
              labelText: 'Password',
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

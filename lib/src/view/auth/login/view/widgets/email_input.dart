import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login.dart';

class EmailInput extends StatelessWidget {
  final EdgeInsets padding;
  const EmailInput({
    required this.padding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_emailInput'),
            keyboardType: TextInputType.emailAddress,
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(value: email),
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email_outlined),
              errorText: state.errorMessage,
            ),
          );
        },
      ),
    );
  }
}

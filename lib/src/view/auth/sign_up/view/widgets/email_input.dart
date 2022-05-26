import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../sign_up.dart';

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
      child: BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextField(
            key: const Key('signUpForm_emailInput'),
            keyboardType: TextInputType.emailAddress,
            onChanged: (email) =>
                context.read<SignUpCubit>().emailChanged(value: email),
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

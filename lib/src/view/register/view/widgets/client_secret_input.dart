import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../register.dart';

class ClientSecretInput extends StatelessWidget {
  final EdgeInsets padding;

  const ClientSecretInput({required this.padding, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: BlocBuilder<RegisterCubit, RegisterState>(
        buildWhen: (previous, current) =>
            previous.clientSecret != current.clientSecret,
        builder: (context, state) {
          return TextField(
            key: const Key('register_clientSecretInput'),
            keyboardType: TextInputType.emailAddress,
            onChanged: (clientSecret) => context
                .read<RegisterCubit>()
                .clientSecretChanged(value: clientSecret),
            decoration: InputDecoration(
              labelText: 'Client Secret',
              prefixIcon: const Icon(Icons.important_devices_rounded),
              errorText: state.status.isValidated ? state.errorMessage : '',
            ),
          );
        },
      ),
    );
  }
}

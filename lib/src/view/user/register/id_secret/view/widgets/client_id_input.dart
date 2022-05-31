import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../id_secret.dart';

class ClientIdInput extends StatelessWidget {
  final EdgeInsets padding;

  const ClientIdInput({
    required this.padding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: BlocBuilder<IdSecretCubit, IdSecretState>(
        buildWhen: (previous, current) => previous.clientId != current.clientId,
        builder: (context, state) {
          return TextField(
            key: const Key('register_idSecretPage_clientIdInput'),
            onChanged: (clientId) =>
                context.read<IdSecretCubit>().clientIdChanged(value: clientId),
            decoration: InputDecoration(
              labelText: 'Client Id',
              prefixIcon: const Icon(Icons.important_devices_rounded),
              errorText: state.status.isValidated ? state.errorMessage : null,
            ),
          );
        },
      ),
    );
  }
}

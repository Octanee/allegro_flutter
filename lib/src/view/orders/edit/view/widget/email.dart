import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';

import '../../edit.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text: context.read<EditCubit>().state.email.value,
    );
    return BlocBuilder<EditCubit, EditState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(context.paddingMedium),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => context.read<EditCubit>().emailChanged(value),
            decoration: InputDecoration(
              labelText: 'Client email',
              prefixIcon: const Icon(Icons.email_outlined),
              errorText: state.email.invalid ? 'Error' : null,
            ),
          ),
        );
      },
    );
  }
}

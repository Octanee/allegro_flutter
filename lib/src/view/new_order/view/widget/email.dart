import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../cubit/new_order_cubit.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewOrderCubit, NewOrderState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(context.paddingMedium),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) =>
                context.read<NewOrderCubit>().emailChanged(value),
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

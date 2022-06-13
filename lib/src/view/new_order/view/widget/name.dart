import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../cubit/new_order_cubit.dart';

class NameInput extends StatelessWidget {
  const NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewOrderCubit, NewOrderState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(context.paddingMedium),
          child: TextField(
            onChanged: (value) =>
                context.read<NewOrderCubit>().nameChanged(value),
            decoration: InputDecoration(
              labelText: 'Client name',
              prefixIcon: const Icon(Icons.person),
              errorText: state.name.invalid ? 'Error' : null,
            ),
          ),
        );
      },
    );
  }
}

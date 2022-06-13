import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../cubit/new_order_cubit.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewOrderCubit, NewOrderState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(context.paddingMedium),
          child: TextField(
            keyboardType: TextInputType.phone,
            onChanged: (value) =>
                context.read<NewOrderCubit>().phoneChanged(value),
            decoration: InputDecoration(
              labelText: 'Client phone',
              prefixIcon: const Icon(Icons.phone),
              errorText: state.phone.invalid ? 'Error' : null,
            ),
          ),
        );
      },
    );
  }
}

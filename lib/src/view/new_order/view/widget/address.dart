import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../cubit/new_order_cubit.dart';

class AddressInput extends StatelessWidget {
  const AddressInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewOrderCubit, NewOrderState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(context.paddingMedium),
          child: TextField(
            onChanged: (value) =>
                context.read<NewOrderCubit>().addressChanged(value),
            decoration: InputDecoration(
              labelText: 'Client address',
              prefixIcon: const Icon(Icons.location_city_rounded),
              errorText: state.address.invalid ? 'Error' : null,
            ),
          ),
        );
      },
    );
  }
}

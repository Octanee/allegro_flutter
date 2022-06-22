import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';
import '../../edit.dart';

class AddressInput extends StatelessWidget {
  const AddressInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text: context.read<EditCubit>().state.address.value,
    );
    return BlocBuilder<EditCubit, EditState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(context.paddingMedium),
          child: TextField(
            controller: controller,
            onChanged: (value) =>
                context.read<EditCubit>().addressChanged(value),
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

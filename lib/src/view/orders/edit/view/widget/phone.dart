import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';
import '../../edit.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text: context.read<EditCubit>().state.phone.value,
    );
    return BlocBuilder<EditCubit, EditState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(context.paddingMedium),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.phone,
            onChanged: (value) => context.read<EditCubit>().phoneChanged(value),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';
import '../../edit.dart';


class NameInput extends StatelessWidget {
  const NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text: context.read<EditCubit>().state.name.value,
    );
    return BlocBuilder<EditCubit, EditState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(context.paddingMedium),
          child: TextField(
            controller: controller,
            onChanged: (value) =>
                context.read<EditCubit>().nameChanged(value),
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

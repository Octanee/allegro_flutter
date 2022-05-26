import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../register.dart';

class NextButton extends StatelessWidget {
  final EdgeInsets padding;
  final Function()? onPressed;
  const NextButton({required this.padding, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status.isValidated
              ? onPressed
              : null,
          child: Padding(
            padding: padding,
            child: const Text('NEXT'),
          ),
        );
      },
    );
  }
}

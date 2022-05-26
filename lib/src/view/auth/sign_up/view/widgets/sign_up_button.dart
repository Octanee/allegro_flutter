import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../extensions/extension.dart';
import '../../sign_up.dart';

class SignUpButton extends StatelessWidget {
  final EdgeInsets padding;
  const SignUpButton({required this.padding, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: state.status.isValidated
                    ? () async {
                        await context.read<SignUpCubit>().signUp();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      }
                    : null,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.paddingLarge),
                  child: Text(
                    'SIGN UP',
                    style: context.titleLarge
                        ?.copyWith(color: context.colors.primary),
                  ),
                ),
              );
      },
    );
  }
}

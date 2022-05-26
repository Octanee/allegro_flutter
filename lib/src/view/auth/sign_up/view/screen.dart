import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../extensions/extension.dart';
import '../sign_up.dart';
import 'widgets/widgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign Up',
          style: context.displaySmall?.copyWith(
            color: context.colors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentMaterialBanner()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Authentication Failure'),
                ),
              );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  EmailInput(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.paddingXLarge),
                  ),
                  const SizedBox(height: 20.0),
                  PasswordInput(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.paddingXLarge),
                  ),
                  const SizedBox(height: 20.0),
                  ConfirmPasswordInput(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.paddingXLarge),
                  ),
                  const SizedBox(height: 50),
                  SignUpButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.paddingXLarge),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

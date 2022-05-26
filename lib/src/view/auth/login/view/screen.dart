import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../extensions/extension.dart';
import '../login.dart';
import 'widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
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
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              Column(
                children: [
                  EmailInput(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.paddingXLarge),
                  ),
                  const SizedBox(height: 15.0),
                  PasswordInput(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.paddingXLarge),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              Column(
                children: [
                  LoginButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.paddingLarge),
                  ),
                  const SizedBox(height: 4.0),
                  SignUpButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.paddingLarge),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

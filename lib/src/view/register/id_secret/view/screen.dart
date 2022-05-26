import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../extensions/extension.dart';
import '../../register.dart';
import 'widgets/widgets.dart';

class IdSecretScreen extends StatelessWidget {
  const IdSecretScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<IdSecretCubit, IdSecretState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentMaterialBanner()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        } else if (state.status.isSubmissionSuccess) {
          Navigator.of(context).push(
            UserCodePage.route(
              clientId: state.clientId.value,
              clientSecret: state.clientSecret.value,
              deviceCode: state.deviceCode!,
              userCode: state.userCode!,
            ),
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              ClientIdInput(
                padding:
                    EdgeInsets.symmetric(horizontal: context.paddingXLarge),
              ),
              const SizedBox(height: 20),
              ClientSecretInput(
                padding:
                    EdgeInsets.symmetric(horizontal: context.paddingXLarge),
              ),
              const SizedBox(height: 50),
              AuthotrizeButton(
                padding:
                    EdgeInsets.symmetric(horizontal: context.paddingXLarge),
                onPressed: () async {
                  await context.read<IdSecretCubit>().authorize();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

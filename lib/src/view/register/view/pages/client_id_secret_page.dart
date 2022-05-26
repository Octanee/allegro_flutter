import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../extensions/extension.dart';
import '../../register.dart';
import '../widgets/widgets.dart';

class ClientIdSecretPage extends StatelessWidget {
  const ClientIdSecretPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: ClientIdSecretPage());

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
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
          context
              .flow<RegisterStatus>()
              .update((state) => RegisterStatus.token);
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
              NextButton(
                padding:
                    EdgeInsets.symmetric(horizontal: context.paddingXLarge),
                onPressed: () async {
                  await context.read<RegisterCubit>().authorize();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

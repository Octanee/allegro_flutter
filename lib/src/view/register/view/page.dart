import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../allegro_api/allegro_api.dart';
import '../../../allegro_api/allegro_api_environment.dart';
import '../../../config/app_flow.dart';
import '../register.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: RegisterPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        allegroApi: AllegroApi(environment: AllegroApiEnvironment.sandbox),
      ),
      child: const FlowBuilder<RegisterStatus>(
        state: RegisterStatus.auth,
        onGeneratePages: onGenerateRegisterFlow,
      ),
    );
  }
}

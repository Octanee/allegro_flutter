import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/authentication.dart';
import '../../user/user.dart';
import '../auth.dart';

class AuthFlow extends StatelessWidget {
  const AuthFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authenticationRepository: context.read<AuthenticationRepository>(),
        ),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return FlowBuilder<AuthStatus>(
              state: state.status,
              onGeneratePages: _onGenerateAuthFlow,
            );
          },
        ),
      ),
    );
  }

  List<Page> _onGenerateAuthFlow(
    AuthStatus status,
    List<Page<dynamic>> pages,
  ) {
    switch (status) {
      case AuthStatus.authenticated:
        return [UserFlow.page()];
      case AuthStatus.unauthenticated:
        return [LoginPage.page()];
    }
  }
}

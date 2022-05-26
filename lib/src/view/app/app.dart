import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../repository/authentication.dart';
import 'app_screen.dart';

class DecorApp extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;
  const DecorApp({
    required AuthenticationRepository authenticationRepository,
    Key? key,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (context) =>
            AuthBloc(authenticationRepository: _authenticationRepository),
        child: const DecorAppScreen(),
      ),
    );
  }
}

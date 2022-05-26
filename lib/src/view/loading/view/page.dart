import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bloc.dart';
import '../../../repository/authentication.dart';
import '../../../repository/user.dart';
import 'screen.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoadingPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(
        userId: context.read<AuthenticationRepository>().currentUserId,
      ),
      child: BlocProvider(
        create: (context) =>
            UserBloc(userRepository: context.read<UserRepository>()),
        child: const LoadingScreen(),
      ),
    );
  }
}

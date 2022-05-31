import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/repository.dart';
import '../../loading.dart';

class TokenPage extends StatelessWidget {
  const TokenPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: TokenPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TokenCubit(
        allegroAuthorizationRepository: AllegroAuthorizationRepository(),
        userRepository: context.read<UserRepository>(),
      )..updateToken(),
      child: const TokenScreen(),
    );
  }
}

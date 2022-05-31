import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/allegro/allegro_api.dart';
import '../id_secret.dart';

class IdSecretPage extends StatelessWidget {
  const IdSecretPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: IdSecretPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IdSecretCubit(allegroApi: AllegroAuthorizationRepository()),
      child: const IdSecretScreen(),
    );
  }
}

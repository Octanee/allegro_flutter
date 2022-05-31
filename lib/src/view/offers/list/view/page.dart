import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/repository.dart';
import '../../../view.dart';

class OffersListPage extends StatelessWidget {
  const OffersListPage({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (_) => const OffersListPage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListCubit(
        allegroOfferRepository: AllegroOfferRepository(
          accessToken: context.read<UserRepository>().currentUser.accessToken!,
        ),
      )..loadAllegroOffers(),
      child: const OffersListScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/repository.dart';
import '../cubit/synchronization_cubit.dart';
import 'view.dart';

class SynchronizationPage extends StatelessWidget {
  const SynchronizationPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: SynchronizationPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SynchronizationCubit(
        productRepository: ProductRepository(
          userId: context.read<AuthenticationRepository>().currentUserId,
        ),
        allegroOfferRepository: AllegroOfferRepository(
          accessToken: context.read<UserRepository>().currentUser.accessToken!,
        ),
      )..loadOffers(),
      child: const SynchronizationScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/repository.dart';
import '../list.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (_) => const OrderListPage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit(
        allegroOrderRepository: AllegroOrderRepository(
          accessToken: context.read<UserRepository>().currentUser.accessToken!,
        ),
      )..loadOrders(),
      child: const OrderListScreen(),
    );
  }
}

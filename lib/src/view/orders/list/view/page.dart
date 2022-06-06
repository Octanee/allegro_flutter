import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/repository.dart';
import '../cubit/list_cubit.dart';
import 'screen.dart';

class OrdersListPage extends StatelessWidget {
  const OrdersListPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: OrdersListPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListCubit(
        ordersRepository: OrdersRepository(
          userId: context.read<AuthenticationRepository>().currentUserId,
        ),
      )..loadProducts(),
      child: const OrdersListScreen(),
    );
  }
}

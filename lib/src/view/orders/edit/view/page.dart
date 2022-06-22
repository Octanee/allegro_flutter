import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/models.dart';
import '../edit.dart';

class OrderEditPage extends StatelessWidget {
  final Order _order;
  const OrderEditPage({required Order order, Key? key})
      : _order = order,
        super(key: key);

  static Route<Order> route({required Order order}) =>
      MaterialPageRoute(builder: (_) => OrderEditPage(order: order));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditCubit(order: _order)..init(),
      child: const OrderEditScreen(),
    );
  }
}

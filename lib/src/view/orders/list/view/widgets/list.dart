import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';
import '../../../../../models/models.dart';
import 'widgets.dart';

class OrdersList extends StatelessWidget {
  final List<Order> orders;

  const OrdersList({required this.orders, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return orders.isNotEmpty ? _getList() : _getEmptyList(context);
  }

  Widget _getList() {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderListItem(order: order);
      },
    );
  }

  Widget _getEmptyList(BuildContext context) {
    return Center(
      child: Text(
        'Orders list is empty',
        style: context.displayMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}

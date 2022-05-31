import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../../../models/allegro/order.dart';
import '../../../view.dart';
import 'widget/widget.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state.status == OrdersStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('List loading error')),
            );
          }
        },
        builder: (context, state) {
          if (state.status == OrdersStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.orders.isNotEmpty) {
            return _getBody(context, state.orders);
          }
          return _emptyList(context);
        },
      ),
    );
  }

  Widget _getBody(BuildContext context, List<AllegroOrder> orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderListItem(order: order);
      },
    );
  }

  Widget _emptyList(BuildContext context) {
    return Center(
      child: Text(
        'List is Empty',
        style: context.displayMedium,
      ),
    );
  }
}

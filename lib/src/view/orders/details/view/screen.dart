import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../orders.dart';
import 'widgets/widgets.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      buildWhen: (previous, current) => previous.updated != current.updated,
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, state.updated);
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: BlocBuilder<DetailsCubit, DetailsState>(
                buildWhen: (previous, current) =>
                    current.status == DetailsStatus.init,
                builder: (context, state) {
                  return Text(
                    state.order.id,
                    style: context.titleLargePrimary,
                  );
                },
              ),
              // actions: [
              //   IconButton(
              //     icon: const Icon(Icons.edit),
              //     onPressed: () async {
              //       final value = await Navigator.push<Order>(context, route);
              //       if (value != null) {
              //         // ignore: use_build_context_synchronously
              //         context.read<DetailsCubit>().updateOrder(order: value);
              //       }
              //     },
              //   ),
              // ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: const [
                  OrderStatus(),
                  OrderDetailsData(),
                  ClientCard(),
                  ItemsListCard(),
                  OrderPricing(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

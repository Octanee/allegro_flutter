import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';
import '../../../../../widgets/widgets.dart';
import '../../../orders.dart';

class OrderPricing extends StatelessWidget {
  const OrderPricing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        final order = state.order;
        return Card(
          child: Padding(
            padding: EdgeInsets.all(context.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pricing', style: context.labelLarge),
                const SizedBox(height: 12),
                TextRow(
                  isPrice: true,
                  name: 'Price',
                  value: order.price.toString(),
                ),
                TextRow(
                  isPrice: true,
                  name: 'Delivery',
                  value: order.deliverer.price.toString(),
                ),
                const SizedBox(height: 12),
                TextRow(
                  isPrice: true,
                  name: 'Total',
                  value: (order.price + order.deliverer.price).toString(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

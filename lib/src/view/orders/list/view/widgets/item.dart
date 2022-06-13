import 'package:flutter/material.dart';

import '../../../../../extensions/extension.dart';
import '../../../../../models/models.dart';
import '../../../../../widgets/widgets.dart';

class OrderListItem extends StatelessWidget {
  final Order order;
  const OrderListItem({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickableCard(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.id),
              Text(order.lastUpdate.toFormatedString()),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Status:'),
              Text(
                order.status.toString(),
                style: context.bodyLarge,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Deliverer:'),
              Text(
                order.deliverer.toString(),
                style: context.bodyLarge,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Platform:'),
              Text(
                order.platform.toString(),
                style: context.bodyLarge,
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Items:'),
              Text(
                order.items.length.toString(),
                style: context.bodyLarge,
              )
            ],
          ),
        ],
      ),
    );
  }
}

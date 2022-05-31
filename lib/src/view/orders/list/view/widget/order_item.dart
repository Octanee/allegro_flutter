import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../extensions/extension.dart';
import '../../../../../models/models.dart';



class OrderListItem extends StatelessWidget {
  final AllegroOrder order;
  const OrderListItem({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd MMMM yyyy, HH:mm').format(order.occurredAt),
              style: context.labelMedium,
            ),
            for (var item in order.items)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: context.titleMedium,
                    ),
                  ),
                  Text('${item.quantity} x ${item.price}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

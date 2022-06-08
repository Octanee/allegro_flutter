import 'package:flutter/material.dart';

import '../extensions/extension.dart';
import '../models/models.dart';
import '../view/bottom_sheets/order_item_data/view/view.dart';
import 'widgets.dart';

class OrderListItem extends StatelessWidget {
  final OrderItem order;
  final void Function(OrderItem) onTap;

  const OrderListItem({
    required this.order,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.paddingSmall),
      child: InkWell(
        onTap: () async {
          await _onTapItem(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Image.network(order.productImage),
                  ),
                  SizedBox(width: context.paddingMedium),
                  Flexible(
                    child: Text(
                      order.productName,
                      style: context.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text('${order.quantity}', style: context.labelLarge),
                    Text('szt.', style: context.labelSmall),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(context.paddingSmall),
                  child: const Icon(
                    Icons.circle,
                    size: 8,
                  ),
                ),
                Column(
                  children: [
                    Text('${order.price}', style: context.labelLarge),
                    Text('PLN', style: context.labelSmall),
                  ],
                ),
              ],
            ),
            SizedBox(width: context.paddingMedium),
            Icon(
              Icons.edit,
              color: context.colors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapItem(BuildContext context) async {
    var item = await context.showBottomSheet<OrderItem>(
      builder: (context) =>
          OrderItemDataBottomSheet(item: order, saveButtonText: 'Edit'),
    );

    if (item != null) {
      if (item.quantity == 0) {
        // ignore: use_build_context_synchronously
        final delete = await _showDeleteDialog(context);

        if (!delete) item = item.copyWith(quantity: order.quantity);
      }
      onTap(item);
    }
  }

  Future<bool> _showDeleteDialog(BuildContext context) async {
    final value = await showDialog<bool>(
      context: context,
      builder: (context) => const CustomDialog(
        title: 'Delete?',
        text: 'Do you want delete item from order?',
      ),
    );

    if (value != null) {
      return value;
    }
    return false;
  }
}

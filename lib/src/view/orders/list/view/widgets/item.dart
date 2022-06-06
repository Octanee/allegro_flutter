import 'package:flutter/material.dart';

import '../../../../../models/models.dart';
import '../../../../../widgets/widgets.dart';

class OrderListItem extends StatelessWidget {
  final Order order;
  const OrderListItem({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickableCard(
      child: Column(),
    );
  }
}

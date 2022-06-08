import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../../../models/models.dart';
import '../../../../widgets/widgets.dart';
import '../order_item_data.dart';
import 'widget/widget.dart';

class OrderItemDataBottomSheet extends StatelessWidget {
  final OrderItem item;
  final String saveButtonText;

  const OrderItemDataBottomSheet({
    required this.item,
    this.saveButtonText = 'Add',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderItemDataCubit(item: item)..init(),
      child: Padding(
        padding: EdgeInsets.all(context.paddingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DragIcon(),
            const PriceEditCard(),
            const QuantityCard(),
            SaveButton(text: saveButtonText)
          ],
        ),
      ),
    );
  }
}

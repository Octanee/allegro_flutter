import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../../../models/models.dart';
import '../../../../widgets/widgets.dart';
import '../../products.dart';
import 'widget/widget.dart';

class AddToOrder extends StatelessWidget {
  final Product product;

  const AddToOrder({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddToOrderCubit(product: product)..init(),
      child: Padding(
        padding: EdgeInsets.all(context.paddingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            DragIcon(),
            PriceInput(),
            QuantityPicker(),
            AddButton(),
          ],
        ),
      ),
    );
  }
}

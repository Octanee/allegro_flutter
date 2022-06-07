import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';
import '../../../../../widgets/widgets.dart';
import '../../../../new_order/cubit/new_order_cubit.dart';
import '../../../products.dart';

class AddButton extends StatelessWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowButton(
      onPressed: () {
        final item = context.read<AddToOrderCubit>().getOrderItem();

        if (item != null) {
          context.read<NewOrderCubit>().addItem(item: item);
          Navigator.pop(context);
        }
      },
      child: const Text('Add'),
    );
  }
}

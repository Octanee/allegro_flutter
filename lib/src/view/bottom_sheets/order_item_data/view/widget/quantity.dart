import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../widgets/widgets.dart';
import '../../order_item_data.dart';

class QuantityCard extends StatelessWidget {
  const QuantityCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderItemDataCubit, OrderItemDataState>(
      buildWhen: (previous, current) => previous.quantity != current.quantity,
      builder: (context, state) {
        return AddSubtractCard(
          title: 'Quantity',
          value: state.quantity.value,
          maxValue: context.read<OrderItemDataCubit>().maxQuantity,
          onSubtract: () {
            context
                .read<OrderItemDataCubit>()
                .quantityChanged(state.quantity.value - 1);
          },
          onAdd: () {
            context
                .read<OrderItemDataCubit>()
                .quantityChanged(state.quantity.value + 1);
          },
          onTap: () async {
            await showInputDialog(
              context: context,
              initValue: state.quantity.value,
              maxValue: context.read<OrderItemDataCubit>().maxQuantity,
            );
          },
        );
      },
    );
  }

  Future<void> showInputDialog({
    required BuildContext context,
    required int initValue,
    required int maxValue,
  }) async {
    final value = await showDialog<double>(
      context: context,
      builder: (context) => NumberInputDialog(
        title: 'Quantity',
        initValue: initValue.toDouble(),
      ),
    );

    if (value != null) {
      // ignore: use_build_context_synchronously
      context
          .read<OrderItemDataCubit>()
          .quantityChanged(value.toInt().clamp(0, maxValue));
    }
  }
}

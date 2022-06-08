import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../widgets/widgets.dart';
import '../../order_item_data.dart';

class PriceEditCard extends StatelessWidget {
  const PriceEditCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderItemDataCubit, OrderItemDataState>(
      buildWhen: (previous, current) => previous.price != current.price,
      builder: (context, state) {
        return EditCard(
          title: 'Price',
          value: state.price.value.toString(),
          onTap: () async {
            await showInputDialog(
              context: context,
              initValue: state.price.value,
            );
          },
        );
      },
    );
  }

  Future<void> showInputDialog({
    required BuildContext context,
    required double initValue,
  }) async {
    final value = await showDialog<double>(
      context: context,
      builder: (context) => NumberInputDialog(
        title: 'Price',
        initValue: initValue,
      ),
    );

    if (value != null) {
      // ignore: use_build_context_synchronously
      context.read<OrderItemDataCubit>().priceChanged(value);
    }
  }
}

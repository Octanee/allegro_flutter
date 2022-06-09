import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../../../models/models.dart';
import '../../../../widgets/widgets.dart';
import '../../cubit/new_order_cubit.dart';

class DelivererCard extends StatelessWidget {
  const DelivererCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewOrderCubit, NewOrderState>(
      builder: (context, state) {
        return DropdownCard<OrderDeliverer>(
          title: 'Deliverer',
          padding: EdgeInsets.all(context.paddingMedium),
          onChanged: (deliverer) {
            if (deliverer != null) {
              context.read<NewOrderCubit>().delivererChange(deliverer);
            }
          },
          value: state.deliverer,
          items: OrderDeliverer.values
              .map(
                (deliverer) => DropdownMenuItem<OrderDeliverer>(
                  value: deliverer,
                  child: Text(deliverer.toString()),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

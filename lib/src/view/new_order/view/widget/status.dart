import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../../../models/models.dart';
import '../../../../widgets/widgets.dart';
import '../../cubit/new_order_cubit.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewOrderCubit, NewOrderState>(
      builder: (context, state) {
        return DropdownCard<OrderStatus>(
          title: 'Status',
          padding: EdgeInsets.all(context.paddingMedium),
          onChanged: (status) {
            if (status != null) {
              context.read<NewOrderCubit>().statusChange(status);
            }
          },
          value: state.status,
          items: OrderStatus.values
              .map(
                (status) => DropdownMenuItem<OrderStatus>(
                  value: status,
                  child: Text(status.toString()),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

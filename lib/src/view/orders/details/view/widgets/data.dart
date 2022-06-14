import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';
import '../../../../../widgets/widgets.dart';
import '../../../orders.dart';

class OrderDetailsData extends StatelessWidget {
  const OrderDetailsData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        final order = state.order;
        return Card(
          child: Padding(
            padding: EdgeInsets.all(context.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data', style: context.labelLarge),
                const SizedBox(height: 12),
                TextRow(
                  name: 'Occurred At',
                  value: order.occurredAt.toFormatedString(),
                ),
                TextRow(
                  name: 'Deliverer',
                  value: order.deliverer.toString(),
                ),
                TextRow(
                  name: 'platform',
                  value: order.platform.toString(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

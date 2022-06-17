import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';
import '../../../../../widgets/widgets.dart';
import '../../../orders.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(context.paddingMedium),
            child: TextRow(
              name: 'Status',
              value: state.order.status.toString(),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/widgets.dart';
import '../../new_order.dart';

class ItemsListCard extends StatelessWidget {
  const ItemsListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewOrderCubit, NewOrderState>(
      buildWhen: (previous, current) => previous.items != current.items,
      builder: (context, state) {
        final list = state.items;
        return Card(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            primary: false,
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              return OrderListItem(
                order: item,
                onTap: (item) =>
                    context.read<NewOrderCubit>().updateItem(item: item),
              );
            },
          ),
        );
      },
    );
  }
}

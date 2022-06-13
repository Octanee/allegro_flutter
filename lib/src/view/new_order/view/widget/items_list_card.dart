import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../../../models/models.dart';
import '../../../../widgets/widgets.dart';
import '../../../home/home.dart';
import '../../new_order.dart';

class ItemsListCard extends StatelessWidget {
  const ItemsListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewOrderCubit, NewOrderState>(
      buildWhen: (previous, current) => previous.items != current.items,
      builder: (context, state) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(context.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Items'),
                _getList(context: context, list: state.items),
                _getButton(context: context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getButton({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () =>
              context.flow<HomeStatus>().update((state) => HomeStatus.products),
          icon: const Icon(Icons.add),
          label: const Text('ADD'),
        ),
      ],
    );
  }

  Widget _getList({
    required BuildContext context,
    required List<OrderItem> list,
  }) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      primary: false,
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return OrderListItem(
          order: item,
          onTap: (item) => context.read<NewOrderCubit>().updateItem(item: item),
        );
      },
    );
  }
}

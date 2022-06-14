import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';
import '../../../../../widgets/widgets.dart';
import '../../../orders.dart';

class ItemsListCard extends StatelessWidget {
  const ItemsListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        final list = state.order.items;
        return Card(
          child: Padding(
            padding: EdgeInsets.all(context.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Items', style: context.labelLarge),
                const SizedBox(height: 12),
                ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return OrderListItem(
                      edit: false,
                      order: item,
                      onTap: (_) {},
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

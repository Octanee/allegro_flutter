import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';
import '../../../../../models/models.dart';
import '../../../../../widgets/widgets.dart';
import '../../edit.dart';

class PlatformCard extends StatelessWidget {
  const PlatformCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCubit, EditState>(
      builder: (context, state) {
        return DropdownCard<OrderPlatform>(
          title: 'Platform',
          padding: EdgeInsets.all(context.paddingMedium),
          onChanged: (value) {
            if (value != null) {
              context.read<EditCubit>().platformChange(value);
            }
          },
          value: state.platform,
          items: OrderPlatform.values
              .map(
                (value) => DropdownMenuItem<OrderPlatform>(
                  value: value,
                  child: Text(value.toString()),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

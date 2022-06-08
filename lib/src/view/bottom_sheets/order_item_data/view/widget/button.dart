import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../widgets/widgets.dart';
import '../../order_item_data.dart';

class SaveButton extends StatelessWidget {
  final String text;
  const SaveButton({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderItemDataCubit, OrderItemDataState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pop(context, state.order);
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return RowButton(
          onPressed: state.status.isValid
              ? () {
                  context.read<OrderItemDataCubit>().getOrderItem();
                }
              : null,
          child: Text(text),
        );
      },
    );
  }
}

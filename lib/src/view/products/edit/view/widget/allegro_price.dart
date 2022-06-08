import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';
import '../../../../../widgets/widgets.dart';
import '../../edit.dart';

class EditAllegroPrice extends StatelessWidget {
  const EditAllegroPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCubit, EditState>(
      buildWhen: (previous, current) =>
          previous.allegroPrice != current.allegroPrice,
      builder: (context, state) {
        return EditCard(
          title: 'Allegro price',
          value: '${state.allegroPrice.value.toPrice()} PLN',
          isValid: state.allegroPrice.valid,
          onTap: () async {
            await showInputDialog(
              context: context,
              initValue: state.allegroPrice.value,
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
        title: 'Allegro price',
        initValue: initValue,
      ),
    );

    if (value != null) {
      // ignore: use_build_context_synchronously
      context.read<EditCubit>().allegroPriceChanged(value: value);
    }
  }
}

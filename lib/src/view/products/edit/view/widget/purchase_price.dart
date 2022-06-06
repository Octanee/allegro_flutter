import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';
import '../../edit.dart';

class EditPurchasePrice extends StatelessWidget {
  const EditPurchasePrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCubit, EditState>(
      buildWhen: (previous, current) =>
          previous.purchasePrice != current.purchasePrice,
      builder: (context, state) {
        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () async {
              final controller = TextEditingController(
                text: state.purchasePrice.value.toString(),
              );

              final value = await showDialog<double>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Edit purchase price'),
                  content: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                      child: const Text('CANCEL'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final text = controller.text;
                        final value = text.isNotEmpty
                            ? double.parse(text).toPrice()
                            : null;
                        Navigator.pop(context, value);
                      },
                      child: const Text('SAVE'),
                    ),
                  ],
                ),
              );

              if (value != null) {
                // ignore: use_build_context_synchronously
                context.read<EditCubit>().purchasePriceChanged(value: value);
              }
            },
            child: Padding(
              padding: EdgeInsets.all(context.paddingMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Purchase price',
                        style: context.labelMedium,
                      ),
                      Text(
                        '${state.purchasePrice.value.toPrice()} PLN',
                        style: context.titleLargePrimary,
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.edit,
                    color: state.purchasePrice.valid == true
                        ? context.colors.primary
                        : context.colors.error,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

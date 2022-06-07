import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';
import '../../../products.dart';

class PriceInput extends StatelessWidget {
  const PriceInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Text('Price'),
          BlocBuilder<AddToOrderCubit, AddToOrderState>(
            buildWhen: (previous, current) => previous.price != current.price,
            builder: (context, state) {
              return InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () async {
                  final controller = TextEditingController(
                    text: state.price.value.toString(),
                  );

                  final value = await showDialog<double>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Edit price'),
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
                    context.read<AddToOrderCubit>().priceChanged(value: value);
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
                            '${state.price.value.toPrice()} PLN',
                            style: context.titleLargePrimary,
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.edit,
                        color: state.price.valid == true
                            ? context.colors.primary
                            : context.colors.error,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

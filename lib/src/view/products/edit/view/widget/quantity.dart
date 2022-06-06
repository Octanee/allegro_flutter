import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';
import '../../edit.dart';

class EditQuantity extends StatelessWidget {
  const EditQuantity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCubit, EditState>(
      buildWhen: (previous, current) => previous.quantity != current.quantity,
      builder: (context, state) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(context.paddingMedium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: state.quantity.value > 0
                      ? () {
                          context
                              .read<EditCubit>()
                              .quantityChanged(value: state.quantity.value - 1);
                        }
                      : null,
                  child: const Icon(Icons.remove),
                ),
                InkWell(
                  onTap: () async {
                    final controller = TextEditingController(
                      text: state.quantity.value.toString(),
                    );

                    final value = await showDialog<int>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Edit quantity'),
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
                              final value =
                                  text.isNotEmpty ? int.parse(text) : null;
                              Navigator.pop(context, value);
                            },
                            child: const Text('SAVE'),
                          ),
                        ],
                      ),
                    );

                    if (value != null) {
                      // ignore: use_build_context_synchronously
                      context.read<EditCubit>().quantityChanged(value: value);
                    }
                  },
                  child: Text(
                    state.quantity.value.toString(),
                    style: context.titleLargePrimary,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<EditCubit>()
                        .quantityChanged(value: state.quantity.value + 1);
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../extensions/extension.dart';
import '../../products.dart';
import 'widget/widget.dart';

class ProductEditScreen extends StatelessWidget {
  const ProductEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditCubit, EditState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          Navigator.pop(context, state.product);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<EditCubit, EditState>(
            buildWhen: (previous, current) =>
                previous.product.id != current.product.id,
            builder: (context, state) {
              return Text(
                state.product.id,
                style: context.titleLargePrimary,
              );
            },
          ),
          centerTitle: true,
          actions: [
            BlocBuilder<EditCubit, EditState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                return state.status.isValid
                    ? IconButton(
                        onPressed: () {
                          context.read<EditCubit>().updateProduct();
                        },
                        icon: Icon(
                          Icons.save_rounded,
                          color: context.colors.primary,
                        ),
                      )
                    : Container();
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(context.paddingLarge),
          child: Column(
            children: const [
              EditPurchasePrice(),
              EditAllegroPrice(),
              EditQuantity(),
            ],
          ),
        ),
      ),
    );
  }
}

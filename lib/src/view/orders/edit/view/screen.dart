import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../extensions/extension.dart';
import '../cubit/edit_cubit.dart';
import 'widget/widget.dart';

class OrderEditScreen extends StatelessWidget {
  const OrderEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          BlocBuilder<EditCubit, EditState>(
            buildWhen: (previous, current) =>
                previous.formzStatus != current.formzStatus,
            builder: (context, state) {
              return Visibility(
                visible: state.formzStatus.isValid,
                child: IconButton(
                  icon: Icon(
                    Icons.save_rounded,
                    color: context.colors.primary,
                  ),
                  onPressed: () async {
                    await context.read<EditCubit>().updateOrder();
                  },
                ),
              );
            },
          )
        ],
        title: BlocBuilder<EditCubit, EditState>(
          builder: (context, state) {
            return Text(
              state.order.id,
              style: context.titleLargePrimary,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            StatusCard(),
            PlatformCard(),
            DelivererCard(),
            ClientCard(),
            ItemsListCard(),
          ],
        ),
      ),
    );
  }
}

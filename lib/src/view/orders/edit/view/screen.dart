import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../cubit/edit_cubit.dart';

class OrderEditScreen extends StatelessWidget {
  const OrderEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BlocBuilder<EditCubit, EditState>(
          builder: (context, state) {
            return Text(
              state.order.id,
              style: context.titleLargePrimary,
            );
          },
        ),
      ),
    );
  }
}

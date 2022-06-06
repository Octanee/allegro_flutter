import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/widgets.dart';
import '../cubit/list_cubit.dart';
import 'widgets/widgets.dart';

class OrdersListScreen extends StatelessWidget {
  const OrdersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocBuilder<ListCubit, ListState>(
        builder: (context, state) {
          if (state.status == ListStatus.loaded) {
            return OrdersList(orders: state.orders);
          }
          return _getLoadingWidget(context);
        },
      ),
    );
  }

  Widget _getLoadingWidget(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

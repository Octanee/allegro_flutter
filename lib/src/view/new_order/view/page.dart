import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../new_order.dart';

class NewOrderPage extends StatelessWidget {
  const NewOrderPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: NewOrderPage());

  @override
  Widget build(BuildContext context) {
    context.read<NewOrderCubit>().reset();
    return const NewOrderScreen();
  }
}

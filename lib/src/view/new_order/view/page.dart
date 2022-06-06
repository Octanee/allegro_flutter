import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/widgets.dart';
import '../new_order.dart';

class NewOrderPage extends StatelessWidget {
  const NewOrderPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: NewOrderPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewOrderCubit(),
      child: const Scaffold(
        appBar: CustomAppBar(),
      ),
    );
  }
}

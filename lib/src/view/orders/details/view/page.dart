import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/models.dart';
import '../details.dart';
import 'screen.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order _order;

  const OrderDetailsPage({required Order order, Key? key})
      : _order = order,
        super(key: key);

  static Route<bool> route({required Order order}) => MaterialPageRoute(
        builder: (_) => OrderDetailsPage(
          order: order,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit(order: _order),
      child: const OrderDetailsScreen(),
    );
  }
}

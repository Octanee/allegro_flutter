import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../new_order/new_order.dart';
import '../../orders/list/view/page.dart';
import '../../products/list/list.dart';
import '../home.dart';

class HomeFlow extends StatelessWidget {
  const HomeFlow({Key? key}) : super(key: key);

  static Page page() => MaterialPage(
        child: BlocProvider(
          create: (context) => NewOrderCubit(),
          child: const HomeFlow(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<HomeStatus>(
      state: HomeStatus.home,
      onGeneratePages: _onGenerateHomeFlow,
    );
  }

  List<Page> _onGenerateHomeFlow(
    HomeStatus status,
    List<Page<dynamic>> pages,
  ) {
    switch (status) {
      case HomeStatus.home:
        return [HomePage.page()];
      case HomeStatus.products:
        return [ProductsListPage.page()];
      case HomeStatus.orders:
        return [OrdersListPage.page()];
      case HomeStatus.newOrder:
        return [NewOrderPage.page()];
    }
  }
}

enum HomeStatus {
  home,
  products,
  orders,
  newOrder,
}

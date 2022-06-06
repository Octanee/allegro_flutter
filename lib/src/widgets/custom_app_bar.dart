import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import '../view/home/home.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final List<Widget>? actions;

  const CustomAppBar({this.actions, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.flow<HomeStatus>().update((state) => HomeStatus.products);
        return true;
      },
      child: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home_rounded),
          onPressed: () =>
              context.flow<HomeStatus>().update((state) => HomeStatus.home),
        ),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

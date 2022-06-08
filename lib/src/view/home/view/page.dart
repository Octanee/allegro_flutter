import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import '../../../extensions/extension.dart';
import '../../../widgets/widgets.dart';
import '../../loading/loading.dart';
import '../home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(
        child: HomePage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(context.paddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RowButton(
                onPressed: () {
                  context
                      .flow<HomeStatus>()
                      .update((state) => HomeStatus.products);
                },
                child: const Text('Products'),
              ),
              RowButton(
                onPressed: () {
                  context
                      .flow<HomeStatus>()
                      .update((state) => HomeStatus.orders);
                },
                child: const Text('Orders'),
              ),
              RowButton(
                onPressed: () {
                  context
                      .flow<HomeStatus>()
                      .update((state) => HomeStatus.newOrder);
                },
                child: const Text('New Order'),
              ),
              RowButton(
                onPressed: () {
                  context
                      .flow<LoadingStatus>()
                      .update((state) => LoadingStatus.synchronization);
                },
                child: const Text('Synchronization'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

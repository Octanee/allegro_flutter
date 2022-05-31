import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/repository.dart';
import '../view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(OrderListPage.route());
              },
              child: const Text('Orders'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(OffersListPage.route());
              },
              child: const Text('List'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(SynchronizationPage.route());
              },
              child: const Text('Synchronization'),
            ),
            ElevatedButton(
              onPressed: () async {
                await context.read<AuthenticationRepository>().logOut();
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}

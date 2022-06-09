import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/repository.dart';
import '../../products.dart';

class ProductsListPage extends StatelessWidget {
  const ProductsListPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: ProductsListPage());

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    return BlocProvider(
      create: (context) => ListCubit(
        productRepository: ProductRepository(
          userId: context.read<AuthenticationRepository>().currentUserId,
        ),
      )..loadProducts(),
      child: const ProductsListScreen(),
    );
  }
}

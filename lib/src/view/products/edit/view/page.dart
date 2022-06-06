import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/models.dart';
import '../../../../repository/repository.dart';
import '../../products.dart';

class ProductEditPage extends StatelessWidget {
  final Product _product;

  const ProductEditPage({required Product product, Key? key})
      : _product = product,
        super(key: key);

  static Route<Product> route({required Product product}) => MaterialPageRoute(
        builder: (context) => ProductEditPage(product: product),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditCubit(
        product: _product,
        allegroOfferRepository: AllegroOfferRepository(
          accessToken: context.read<UserRepository>().currentUser.accessToken!,
        ),
        productRepository: ProductRepository(
          userId: context.read<AuthenticationRepository>().currentUserId,
        ),
      )..init(),
      child: const ProductEditScreen(),
    );
  }
}

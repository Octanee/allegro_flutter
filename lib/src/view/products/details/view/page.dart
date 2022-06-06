import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/models.dart';
import '../../products.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product _product;

  const ProductDetailsPage({required Product product, Key? key})
      : _product = product,
        super(key: key);

  static Route<bool> route({required Product product}) => MaterialPageRoute(
        builder: (context) => ProductDetailsPage(
          product: product,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit(product: _product),
      child: const ProductDetailsScreen(),
    );
  }
}

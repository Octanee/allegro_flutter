import 'package:flutter/material.dart';

import '../models/models.dart';
import 'widgets.dart';

class ProductsList extends StatelessWidget {
  final List<Product> products;

  const ProductsList({required this.products, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductItem(product: product);
      },
    );
  }
}

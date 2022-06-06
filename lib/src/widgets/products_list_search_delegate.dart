import 'package:flutter/material.dart';

import '../extensions/extension.dart';
import '../models/models.dart';
import 'widgets.dart';

class ProductsListSearchDelegate extends SearchDelegate {
  final List<Product> products;

  ProductsListSearchDelegate(this.products);

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
              showSuggestions(context);
            }
          },
          icon: const Icon(Icons.clear),
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: Icon(
          Icons.arrow_back,
          color: context.colors.primary,
        ),
      );

  @override
  Widget buildResults(BuildContext context) {
    final list = products.where((product) {
      final input = query.toUpperCase();

      return product.id.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final product = list[index];
        return ProductItem(product: product);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = products
        .where((product) {
          final input = query.toUpperCase();

          return product.id.contains(input);
        })
        .map((result) => result.id)
        .toList();

    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: suggestions.length.clamp(0, 5),
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}

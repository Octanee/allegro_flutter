import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../extensions/extension.dart';
import '../models/models.dart';
import '../view/products/products.dart';
import 'widgets.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickableCard(
      onTap: () async {
        final updated = await Navigator.push<bool>(
          context,
          ProductDetailsPage.route(product: product),
        );
        if (updated != null && updated) {
          // ignore: use_build_context_synchronously
          await context.read<ListCubit>().loadProducts();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: context.width * 0.25,
                child: Image.network(product.imageUrl),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: context.width * 0.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.id,
                      style: context.bodySmall,
                    ),
                    Text(
                      product.name,
                      maxLines: 5,
                      style: context.titleMedium,
                    ),
                    Text(
                      product.allegroId,
                      style: context.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Icon(
            Icons.info_outline,
            color: product.purchasePrice != null
                ? Colors.black
                : context.colors.error,
          ),
        ],
      ),
    );
  }
}

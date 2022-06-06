import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../../../models/models.dart';
import '../../products.dart';
import 'widget/widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      buildWhen: (previous, current) => previous.updated != current.updated,
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, state.updated);
            return true;
          },
          child: Scaffold(
            floatingActionButton: const AddToOrderFab(),
            appBar: AppBar(
              title: BlocBuilder<DetailsCubit, DetailsState>(
                builder: (context, state) {
                  return Text(
                    state.product.id,
                    style: context.titleLargePrimary,
                  );
                },
              ),
              actions: [
                BlocBuilder<DetailsCubit, DetailsState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () async {
                        final value = await Navigator.push<Product>(
                          context,
                          ProductEditPage.route(product: state.product),
                        );
                        if (value != null) {
                          // ignore: use_build_context_synchronously
                          context
                              .read<DetailsCubit>()
                              .updateProduct(product: value);
                        }
                      },
                      icon: const Icon(Icons.edit),
                    );
                  },
                ),
              ],
              centerTitle: true,
            ),
            body: BlocBuilder<DetailsCubit, DetailsState>(
              builder: (context, state) {
                final product = state.product;
                return Padding(
                  padding: EdgeInsets.all(context.paddingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: context.height / 3,
                            child: Image.network(product.imageUrl),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              style: context.headlineLargePrimary,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(context.paddingMedium),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Allegro ID',
                                    style: context.labelMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product.allegroId,
                                    style: context.bodyLarge,
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  //TODO Open browser
                                  log('https://allegro.pl.allegrosandbox.pl/oferta/${product.allegroId}');
                                },
                                icon: Icon(
                                  Icons.web,
                                  color: context.colors.primary,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(context.paddingMedium),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Purchase price:'),
                                  Row(
                                    children: [
                                      Text(
                                        (product.purchasePrice ?? 0)
                                            .toStringAsFixed(2),
                                        style: context.labelLarge,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'PLN',
                                        style: context.labelMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Allegro price:'),
                                  Row(
                                    children: [
                                      Text(
                                        product.allegroPrice.toStringAsFixed(2),
                                        style: context.labelLarge,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'PLN',
                                        style: context.labelMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(context.paddingMedium),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Quantity:'),
                              const SizedBox(width: 4),
                              Row(
                                children: [
                                  Text(
                                    '${product.quantity}',
                                    style: context.labelLarge,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'szt',
                                    style: context.labelMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

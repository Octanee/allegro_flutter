import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../../../widgets/widgets.dart';
import '../../products.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          BlocBuilder<ListCubit, ListState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.search_rounded),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: ProductsListSearchDelegate(state.products),
                  );
                },
              );
            },
          )
        ],
      ),
      body: BlocBuilder<ListCubit, ListState>(
        builder: (context, state) {
          if (state.status == ListStatus.loaded) {
            if (state.products.isEmpty) {
              return _getEmptyList(context);
            }
            return ProductsList(products: state.products);
          }
          return _getLoadingWidget(context);
        },
      ),
    );
  }

  Widget _getEmptyList(BuildContext context) {
    return Center(
      child: Expanded(
        child: Text('List is empty', style: context.displayMedium),
      ),
    );
  }

  Widget _getLoadingWidget(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

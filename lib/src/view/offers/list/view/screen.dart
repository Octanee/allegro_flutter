import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../../../models/allegro/offer.dart';
import '../../../view.dart';
import 'widgets/widgets.dart';

class OffersListScreen extends StatelessWidget {
  const OffersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<ListCubit, ListState>(
        listener: (context, state) {
          if (state.status == ListStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('List loading error')),
            );
          }
        },
        builder: (context, state) {
          if (state.status == ListStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.offers.isNotEmpty) {
            return _getBody(context, state.offers);
          }
          return _emptyList(context);
        },
      ),
    );
  }

  Widget _getBody(BuildContext context, List<AllegroOffer> offers) {
    return ListView.builder(
      itemCount: offers.length,
      itemBuilder: (context, index) {
        final offer = offers[index];
        return OfferItem(offer: offer);
      },
    );
  }

  Widget _emptyList(BuildContext context) {
    return Center(
      child: Text(
        'List is Empty',
        style: context.displayMedium,
      ),
    );
  }
}

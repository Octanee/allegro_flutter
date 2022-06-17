import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions/extension.dart';
import '../../../../../models/models.dart';
import '../../../orders.dart';

class ClientCard extends StatelessWidget {
  const ClientCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      buildWhen: (previous, current) =>
          previous.order.customer != current.order.customer,
      builder: (context, state) {
        final customer = state.order.customer;
        return Card(
          child: Padding(
            padding: EdgeInsets.all(context.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customer:',
                  style: context.labelLarge,
                ),
                const SizedBox(height: 12),
                _nameRow(customer, context),
                _addressRow(customer, context),
                _emailRow(customer, context),
                _phoneRow(customer, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _nameRow(Customer customer, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Name'),
        Text(
          customer.name,
          style: context.bodyLarge,
        ),
      ],
    );
  }

  Widget _addressRow(Customer customer, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Address'),
        Text(
          customer.address,
          style: context.bodyLarge,
        ),
      ],
    );
  }

  Widget _emailRow(Customer customer, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Email'),
        Text(
          customer.email,
          style: context.bodyLarge,
        ),
      ],
    );
  }

  Widget _phoneRow(Customer customer, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Phone'),
        Text(
          customer.phone,
          style: context.bodyLarge,
        ),
      ],
    );
  }
}

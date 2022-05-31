import 'package:flutter/material.dart';

import '../../../../../extensions/extension.dart';
import '../../../../../models/models.dart';

class OfferItem extends StatelessWidget {
  final AllegroOffer offer;
  const OfferItem({required this.offer, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(context.paddingMedium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(offer.primaryImage),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer.name,
                        style: context.titleLarge,
                      ),
                      Text(
                        'nr: ${offer.id}',
                        style: context.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text('${offer.price} zł'),
                  const SizedBox(height: 10),
                  Text('${offer.available} szt'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

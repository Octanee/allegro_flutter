import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';
import 'widget/items_list_card.dart';

class NewOrderScreen extends StatelessWidget {
  const NewOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ItemsListCard(),
          ],
        ),
      ),
    );
  }
}

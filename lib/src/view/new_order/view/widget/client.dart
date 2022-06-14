import 'package:flutter/material.dart';

import 'widget.dart';

class ClientCard extends StatelessWidget {
  const ClientCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: const [
          NameInput(),
          AddressInput(),
          EmailInput(),
          PhoneInput(),
        ],
      ),
    );
  }
}

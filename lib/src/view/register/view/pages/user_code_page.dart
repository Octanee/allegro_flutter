import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../register.dart';

class UserCodePage extends StatelessWidget {
  const UserCodePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: UserCodePage());

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {},
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.read<RegisterCubit>().userCode,
              style: context.displayMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                context.read<RegisterCubit>().verificationUri,
                style: context.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            FutureBuilder(
              future: context.read<RegisterCubit>().getToken(),
              builder: (context, snapshot) {
                
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}

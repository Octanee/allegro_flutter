import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/loading_cubit.dart';
import '../token.dart';

class TokenScreen extends StatelessWidget {
  const TokenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            _getStatusWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _getStatusWidget(BuildContext context) {
    return BlocConsumer<TokenCubit, TokenState>(
      listener: (context, state) {
        if (state.status == TokenStatus.complete) {
          context
              .flow<LoadingStatus>()
              .update((state) => LoadingStatus.synchronization);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case TokenStatus.updatingToken:
            return const Text('Updating access token.');
          case TokenStatus.tokenUpdated:
            context.read<TokenCubit>().updateUser();
            break;
          case TokenStatus.updatingUser:
            return const Text('Updating user data.');
          case TokenStatus.error:
            return Text('Error! ${state.errorMessage}');
          default:
            return Container();
        }
        return Container();
      },
    );
  }
}

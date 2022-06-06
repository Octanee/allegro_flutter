import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../extensions/extension.dart';
import '../../loading.dart';

class SynchronizationScreen extends StatelessWidget {
  const SynchronizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
    return BlocConsumer<SynchronizationCubit, SynchronizationState>(
      listener: (context, state) {
        if (state.status == SynchronizationStatus.completed) {
          context.showSnackBar(message: 'Synchronization completed');
          context
              .flow<LoadingStatus>()
              .update((state) => LoadingStatus.complete);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case SynchronizationStatus.offersLoading:
            return const Text('Loading offers from Allegro');
          case SynchronizationStatus.offersLoadded:
            context.read<SynchronizationCubit>().loadProducts();
            break;
          case SynchronizationStatus.productsLoading:
            return const Text('Loading products from database');

          case SynchronizationStatus.productsLoadded:
            context.read<SynchronizationCubit>().checkProducts();
            break;
          case SynchronizationStatus.checkingProducts:
            return Column(
              children: [
                const Text('Checking products data'),
                Text('${state.index} / ${state.offers.length}'),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.paddingLarge),
                  child: LinearProgressIndicator(
                    value: (state.index / state.offers.length),
                  ),
                ),
              ],
            );
          case SynchronizationStatus.checkingCompleted:
            context.read<SynchronizationCubit>().updateProducts();
            break;
          case SynchronizationStatus.updating:
            return Column(
              children: [
                const Text('Updating products data'),
                Text('${state.index} / ${state.updateNeeded.length}'),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.paddingLarge),
                  child: LinearProgressIndicator(
                    value: (state.index / state.updateNeeded.length),
                  ),
                ),
              ],
            );
          case SynchronizationStatus.error:
            return Text(state.errorMessage ?? '');

          default:
            return Container();
        }
        return Container();
      },
    );
  }
}

import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../extensions/extension.dart';
import '../../../widgets/widgets.dart';
import '../../home/home.dart';
import '../new_order.dart';
import 'widget/widget.dart';

class NewOrderScreen extends StatelessWidget {
  const NewOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          _getActions(context),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            StatusCard(),
            PlatformCard(),
            DelivererCard(),
            ClientCard(),
            ItemsListCard(),
          ],
        ),
      ),
    );
  }

  Widget _getActions(BuildContext context) {
    return BlocConsumer<NewOrderCubit, NewOrderState>(
      listener: (context, state) {
        if (state.formzStatus == FormzStatus.submissionSuccess) {
          context.read<NewOrderCubit>().newOrder();
          context.flow<HomeStatus>().update((state) => HomeStatus.orders);
        } else if (state.formzStatus == FormzStatus.submissionFailure) {
          context.showSnackBar(message: state.errorMessage ?? 'Error');
          context.read<NewOrderCubit>().validate();
        }
      },
      builder: (context, state) {
        if (state.formzStatus == FormzStatus.submissionInProgress) {
          return const Center(child:  CircularProgressIndicator());
        } else {
          final canSave = state.formzStatus.isValid && state.items.isNotEmpty;
          if (canSave) {
            return IconButton(
              onPressed: () async {
                await context.read<NewOrderCubit>().saveOrder();
              },
              icon: const Icon(Icons.save),
            );
          } else {
            return Container();
          }
        }
      },
    );
  }
}

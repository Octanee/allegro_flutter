import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/models.dart';
import '../../../../utils/invoice_generator.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit({required Order order}) : super(DetailsState(order: order));

  void updateOrder({required Order order}) {
    emit(state.copyWith(order: order, updated: true));
  }

  Future<void> generateInvoice() async {
    try {
      emit(state.copyWith(status: DetailsStatus.generateInvoice));

      final invoice = await InvoiceGenerator().generate(order: state.order);

      emit(state.copyWith(status: DetailsStatus.generated, invoice: invoice));
    } catch (e) {
      emit(
        state.copyWith(status: DetailsStatus.error, errorMessage: e.toString()),
      );
    }
  }
}

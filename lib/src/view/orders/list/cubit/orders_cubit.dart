import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../exceptions/exceptions.dart';
import '../../../../models/models.dart';
import '../../../../repository/repository.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final AllegroOrderRepository _allegroOrderRepository;

  OrdersCubit({required AllegroOrderRepository allegroOrderRepository})
      : _allegroOrderRepository = allegroOrderRepository,
        super(const OrdersState());

  Future<void> loadOrders() async {
    try {
      emit(state.copyWith(status: OrdersStatus.loading));

      final list = await _allegroOrderRepository.getOrders();

      log(list.toString());
      emit(
        state.copyWith(
          status: OrdersStatus.loaded,
          orders: list,
        ),
      );
    } on AllegroApiException catch (e) {
      emit(
        state.copyWith(
          status: OrdersStatus.error,
          errorMessage: 'ERROR ${e.code}: ${e.message}',
        ),
      );
    }
  }
}

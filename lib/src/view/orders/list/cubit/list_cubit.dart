import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/models.dart';
import '../../../../repository/repository.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  final OrdersRepository _ordersRepository;

  ListCubit({required OrdersRepository ordersRepository})
      : _ordersRepository = ordersRepository,
        super(const ListState());

  void loadProducts() async {
    try {
      emit(state.copyWith(status: ListStatus.loading));

      var list = await _ordersRepository.orders;

      emit(state.copyWith(status: ListStatus.loaded, orders: list));
    } catch (e) {
      emit(
        state.copyWith(
          status: ListStatus.error,
          errorMessage: 'Error => loadProducts {$e}',
        ),
      );
    }
  }
}

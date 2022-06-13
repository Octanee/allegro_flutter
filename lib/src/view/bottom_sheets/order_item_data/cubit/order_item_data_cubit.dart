import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../input/input.dart';
import '../../../../models/models.dart';

part 'order_item_data_state.dart';

class OrderItemDataCubit extends Cubit<OrderItemDataState> {
  final OrderItem item;
  final int maxQuantity;

  OrderItemDataCubit({
    required this.item,
    required this.maxQuantity,
  }) : super(const OrderItemDataState());

  void init() async {
    final price = Price.dirty(item.price);
    final quantity = Quantity.dirty(item.quantity);

    emit(
      state.copyWith(
        price: price,
        quantity: quantity,
        status: Formz.validate([price, quantity]),
      ),
    );
  }

  void priceChanged(double value) {
    final price = Price.dirty(value);
    emit(
      state.copyWith(
        price: price,
        status: Formz.validate([price, state.quantity]),
      ),
    );
  }

  void quantityChanged(int value) {
    final quantity = Quantity.dirty(value);
    emit(
      state.copyWith(
        quantity: quantity,
        status: Formz.validate([quantity, state.price]),
      ),
    );
  }

  void getOrderItem() {
    if (state.status.isInvalid) return;

    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final order =
        item.copyWith(quantity: state.quantity.value, price: state.price.value);

    emit(state.copyWith(status: FormzStatus.submissionSuccess, order: order));
  }
}

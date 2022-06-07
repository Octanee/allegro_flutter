import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../input/input.dart';
import '../../../../models/models.dart';

part 'add_to_order_state.dart';

class AddToOrderCubit extends Cubit<AddToOrderState> {
  final Product product;

  AddToOrderCubit({required this.product}) : super(const AddToOrderState());

  void init() {
    const quantity = Quantity.dirty(1);
    final price = Price.dirty(product.allegroPrice);
    emit(
      state.copyWith(
        quantity: quantity,
        price: price,
        status: Formz.validate([quantity, price]),
      ),
    );
  }

  void priceChanged({required double value}) {
    final price = Price.dirty(value);
    emit(
      state.copyWith(
        price: price,
        status: Formz.validate([price, state.quantity]),
      ),
    );
  }

  void quantityChanged({required int value}) {
    final quantity = Quantity.dirty(value);
    emit(
      state.copyWith(
        quantity: quantity,
        status: Formz.validate([state.price, quantity]),
      ),
    );
  }

  OrderItem? getOrderItem() {
    if (!state.status.isValidated) return null;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final item = OrderItem(
      price: state.price.value,
      quantity: state.quantity.value,
      productId: product.id,
    );

    emit(state.copyWith(status: FormzStatus.submissionSuccess));

    return item;
  }
}

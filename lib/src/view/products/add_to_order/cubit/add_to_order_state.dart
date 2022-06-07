part of 'add_to_order_cubit.dart';

class AddToOrderState extends Equatable {
  final Quantity quantity;
  final Price price;
  final FormzStatus status;
  final String? errorMessage;

  const AddToOrderState({
    this.quantity = const Quantity.dirty(1),
    this.price = const Price.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  @override
  List<Object> get props => [quantity, price, status];

  AddToOrderState copyWith({
    Quantity? quantity,
    Price? price,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return AddToOrderState(
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

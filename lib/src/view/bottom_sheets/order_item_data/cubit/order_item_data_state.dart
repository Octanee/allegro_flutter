part of 'order_item_data_cubit.dart';

class OrderItemDataState extends Equatable {
  final Price price;
  final Quantity quantity;
  final FormzStatus status;
  final String? errorMessage;

  final OrderItem? order;

  const OrderItemDataState({
    this.price = const Price.pure(),
    this.quantity = const Quantity.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.order,
  });

  @override
  List<Object?> get props => [price, quantity, status, order];

  OrderItemDataState copyWith({
    Price? price,
    Quantity? quantity,
    FormzStatus? status,
    String? errorMessage,
    OrderItem? order,
  }) {
    return OrderItemDataState(
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      order: order ?? this.order,
    );
  }
}

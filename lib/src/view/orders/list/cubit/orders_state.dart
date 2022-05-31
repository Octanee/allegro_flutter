part of 'orders_cubit.dart';

enum OrdersStatus {
  loading,
  loaded,
  error,
}

class OrdersState extends Equatable {
  final List<AllegroOrder> orders;
  final OrdersStatus status;
  final String? errorMessage;

  const OrdersState({
    this.orders = const [],
    this.status = OrdersStatus.loading,
    this.errorMessage,
  });

  @override
  List<Object> get props => [orders, status];

  OrdersState copyWith({
    List<AllegroOrder>? orders,
    OrdersStatus? status,
    String? errorMessage,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

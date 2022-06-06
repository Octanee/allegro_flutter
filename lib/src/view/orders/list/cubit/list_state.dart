part of 'list_cubit.dart';

enum ListStatus {
  init,
  loading,
  loaded,
  error,
}

class ListState extends Equatable {
  final List<Order> orders;
  final ListStatus status;
  final String? errorMessage;

  const ListState({
    this.orders = const [],
    this.status = ListStatus.init,
    this.errorMessage,
  });

  @override
  List<Object> get props => [orders, status];

  ListState copyWith({
    List<Order>? orders,
    ListStatus? status,
    String? errorMessage,
  }) {
    return ListState(
      orders: orders ?? this.orders,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return '$runtimeType { status: $status, orders: #${orders.length} }';
  }
}

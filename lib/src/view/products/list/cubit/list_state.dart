part of 'list_cubit.dart';

enum ListStatus {
  init,
  loading,
  loaded,
  error,
}

class ListState extends Equatable {
  final List<Product> products;
  final ListStatus status;
  final String? errorMessage;

  const ListState({
    this.products = const [],
    this.status = ListStatus.init,
    this.errorMessage,
  });

  @override
  List<Object> get props => [products, status];

  ListState copyWith({
    List<Product>? products,
    ListStatus? status,
    String? errorMessage,
  }) {
    return ListState(
      products: products ?? this.products,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return '$runtimeType { status: $status, products: #${products.length} }';
  }
}

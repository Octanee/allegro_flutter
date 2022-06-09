part of 'list_cubit.dart';

enum ListStatus {
  init,
  loading,
  loaded,
  query,
  error,
}

class ListState extends Equatable {
  final List<Product> products;
  final List<Product> displayList;

  final String query;

  final ListStatus status;
  final String? errorMessage;

  const ListState({
    this.products = const [],
    this.query = '',
    this.displayList = const [],
    this.status = ListStatus.init,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [products, status, displayList, query];

  ListState copyWith({
    List<Product>? products,
    List<Product>? displayList,
    ListStatus? status,
    String? errorMessage,
    String? query,
  }) {
    return ListState(
      products: products ?? this.products,
      displayList: displayList ?? this.displayList,
      status: status ?? this.status,
      query: query ?? this.query,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return '$runtimeType { status: $status, products: #${products.length} }';
  }
}

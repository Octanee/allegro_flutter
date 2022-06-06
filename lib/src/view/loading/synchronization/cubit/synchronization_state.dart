part of 'synchronization_cubit.dart';

enum SynchronizationStatus {
  init,
  offersLoading,
  offersLoadded,
  productsLoading,
  productsLoadded,
  checkingProducts,
  checkingCompleted,
  updating,
  completed,
  error,
}

class SynchronizationState extends Equatable {
  final List<AllegroOffer> offers;
  final List<Product> products;
  final List<Product> updateNeeded;
  final int index;
  final SynchronizationStatus status;
  final String? errorMessage;

  const SynchronizationState({
    this.offers = const [],
    this.products = const [],
    this.updateNeeded = const [],
    this.index = 0,
    this.status = SynchronizationStatus.init,
    this.errorMessage,
  });

  @override
  List<Object> get props => [offers, products, status, updateNeeded, index];

  SynchronizationState copyWith({
    List<AllegroOffer>? offers,
    List<Product>? products,
    List<Product>? updateNeeded,
    int? index,
    SynchronizationStatus? status,
    String? errorMessage,
  }) {
    return SynchronizationState(
      offers: offers ?? this.offers,
      products: products ?? this.products,
      updateNeeded: updateNeeded ?? this.updateNeeded,
      index: index ?? this.index,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return '$runtimeType { status: $status, offer: #${offers.length}, products: #${products.length}, updateNeeded: #${updateNeeded.length} }';
  }
}

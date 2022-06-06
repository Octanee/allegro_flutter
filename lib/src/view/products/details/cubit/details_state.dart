part of 'details_cubit.dart';

enum DetailsStatus { init, loading, loaded, error }

class DetailsState extends Equatable {
  final Product product;
  final DetailsStatus status;
  final String? errorMessage;
  final bool updated;

  const DetailsState({
    required this.product,
    this.status = DetailsStatus.init,
    this.updated = false,
    this.errorMessage,
  });

  @override
  List<Object> get props => [
        updated,
        product,
        status,
      ];

  DetailsState copyWith({
    Product? product,
    DetailsStatus? status,
    String? errorMessage,
    bool? updated,
  }) {
    return DetailsState(
      product: product ?? this.product,
      status: status ?? this.status,
      updated: updated ?? this.updated,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

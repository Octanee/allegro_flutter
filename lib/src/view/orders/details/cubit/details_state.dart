part of 'details_cubit.dart';

enum DetailsStatus { init, loading, loaded, error }

class DetailsState extends Equatable {
  final Order order;
  final DetailsStatus status;
  final String? errorMessage;
  final bool updated;

  const DetailsState({
    required this.order,
    this.status = DetailsStatus.init,
    this.updated = false,
    this.errorMessage,
  });

  @override
  List<Object> get props => [
        updated,
        order,
        status,
      ];

  DetailsState copyWith({
    Order? order,
    DetailsStatus? status,
    String? errorMessage,
    bool? updated,
  }) {
    return DetailsState(
      order: order ?? this.order,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      updated: updated ?? this.updated,
    );
  }
}

part of 'list_cubit.dart';

enum ListStatus {
  loading,
  loaded,
  error,
}

class ListState extends Equatable {
  final List<AllegroOffer> offers;
  final ListStatus status;
  final String? errorMessage;

  const ListState({
    this.offers = const [],
    this.status = ListStatus.loading,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [offers, status, errorMessage];

  ListState copyWith({
    List<AllegroOffer>? offers,
    ListStatus? status,
    String? errorMessage,
  }) {
    return ListState(
      offers: offers ?? this.offers,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

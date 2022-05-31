part of 'loading_cubit.dart';

enum LoadingStatus {
  loading,
  loaded,
  complete,
  error,
}

class LoadingState extends Equatable {
  final LoadingStatus status;
  final String? errorMessage;

  const LoadingState({
    this.status = LoadingStatus.loading,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, errorMessage];

  LoadingState copyWith({
    LoadingStatus? status,
    String? errorMessage,
  }) {
    return LoadingState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

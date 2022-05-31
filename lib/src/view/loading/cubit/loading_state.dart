part of 'loading_cubit.dart';

enum LoadingStatus {
  token,
  synchronization,
  complete,
}

class LoadingState extends Equatable {
  final LoadingStatus status;
  final String? errorMessage;

  const LoadingState({
    this.status = LoadingStatus.token,
    this.errorMessage,
  });

  @override
  List<Object> get props => [status];

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

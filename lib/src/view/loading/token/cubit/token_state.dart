part of 'token_cubit.dart';

enum TokenStatus {
  init,
  updatingToken,
  tokenUpdated,
  updatingUser,
  complete,
  error
}

class TokenState extends Equatable {
  final String accessToken;
  final String refreshToken;
  final TokenStatus status;
  final String? errorMessage;

  const TokenState({
    this.status = TokenStatus.init,
    this.accessToken = '',
    this.refreshToken = '',
    this.errorMessage,
  });

  @override
  List<Object> get props => [accessToken, refreshToken, status];

  TokenState copyWith({
    String? accessToken,
    String? refreshToken,
    TokenStatus? status,
    String? errorMessage,
  }) {
    return TokenState(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return '$runtimeType { status: $status }';
  }
}

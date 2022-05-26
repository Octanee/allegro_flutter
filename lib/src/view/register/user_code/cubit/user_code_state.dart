part of 'user_code_cubit.dart';

enum UserCodeStatus {
  init,
  waiting,
  createUser,
  complete,
  error,
}

class UserCodeState extends Equatable {
  final UserCodeStatus status;
  final String? accessToken;
  final String? refreshToken;
  final String? expiresIn;
  final String? errorMessage;

  const UserCodeState({
    this.status = UserCodeStatus.init,
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken, expiresIn];

  UserCodeState copyWith({
    UserCodeStatus? status,
    String? accessToken,
    String? refreshToken,
    String? expiresIn,
    String? errorMessage,
  }) {
    return UserCodeState(
      status: status ?? this.status,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

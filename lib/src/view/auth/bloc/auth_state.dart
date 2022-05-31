part of 'auth_bloc.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final String userId;

  const AuthState._({required this.status, this.userId = ''});

  const AuthState.authenticated({required String userId})
      : this._(status: AuthStatus.authenticated, userId: userId);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status, userId];
}

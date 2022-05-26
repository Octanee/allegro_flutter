part of 'user_bloc.dart';

enum UserStatus {
  loading,
  loaded,
}

class UserState extends Equatable {
  final UserStatus status;
  final User user;

  const UserState._({
    required this.status,
    this.user = User.empty,
  });

  const UserState.loaded({required User user})
      : this._(status: UserStatus.loaded, user: user);

  const UserState.loading() : this._(status: UserStatus.loading);

  @override
  List<Object> get props => [status, user];
}

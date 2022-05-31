part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LogoutRequested extends AuthEvent {}

class UserIdChanged extends AuthEvent {
  final String userId;

  const UserIdChanged({required this.userId});

  @override
  List<Object> get props => [userId];
}

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/authentication.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<String> _userIdSubscription;

  AuthBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUserId.isNotEmpty
              ? AuthState.authenticated(
                  userId: authenticationRepository.currentUserId,
                )
              : const AuthState.unauthenticated(),
        ) {
    _userIdSubscription = _authenticationRepository.userId.listen(
      (userId) => add(UserIdChanged(userId: userId)),
    );

    on<UserIdChanged>(_onUserIdChanged);
    on<LogoutRequested>(_onLogoutRequested);
  }

  void _onUserIdChanged(UserIdChanged event, Emitter<AuthState> emit) {
    emit(
      event.userId.isNotEmpty
          ? AuthState.authenticated(userId: event.userId)
          : const AuthState.unauthenticated(),
    );
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userIdSubscription.cancel();
    return super.close();
  }
}

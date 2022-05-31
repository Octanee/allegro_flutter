import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../repository/repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  late final StreamSubscription<User> _userSubsription;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const UserState.loading()) {
    _userSubsription =
        _userRepository.user.listen((user) => add(UserChanged(user: user)));

    on<UserChanged>(_onUserChanged);
  }

  void _onUserChanged(UserChanged event, Emitter<UserState> emit) {
    emit(UserState.loaded(user: event.user));
  }

  @override
  Future<void> close() {
    _userSubsription.cancel();
    return super.close();
  }
}

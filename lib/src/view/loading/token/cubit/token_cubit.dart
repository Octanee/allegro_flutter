import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/repository.dart';

part 'token_state.dart';

class TokenCubit extends Cubit<TokenState> {
  final AllegroAuthorizationRepository _allegroAuthorizationRepository;
  final UserRepository _userRepository;

  TokenCubit({
    required AllegroAuthorizationRepository allegroAuthorizationRepository,
    required UserRepository userRepository,
  })  : _allegroAuthorizationRepository = allegroAuthorizationRepository,
        _userRepository = userRepository,
        super(const TokenState());

  Future<void> updateToken() async {
    try {
      emit(state.copyWith(status: TokenStatus.updatingToken));

      final user = _userRepository.currentUser;

      final data = await _allegroAuthorizationRepository.refreshToken(
        clientId: user.clientId!,
        clientSecret: user.clientSecret!,
        refreshToken: user.refreshToken!,
      );

      emit(
        state.copyWith(
          status: TokenStatus.tokenUpdated,
          accessToken: data['access_token'],
          refreshToken: data['refresh_token'],
        ),
      );
    } catch (e) {
      log('Error => updateToken: $e');
    }
  }

  Future<void> updateUser() async {
    try {
      emit(state.copyWith(status: TokenStatus.updatingUser));

      final user = _userRepository.currentUser.copyWith(
        accessToken: state.accessToken,
        refreshToken: state.refreshToken,
      );

      await _userRepository.updateUser(user: user);

      emit(state.copyWith(status: TokenStatus.complete));
    } catch (e) {
      log('Error => updateUser: $e');
    }
  }
}

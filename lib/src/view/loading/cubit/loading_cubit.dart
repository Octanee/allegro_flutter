import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../exceptions/allegro_api/allegro_api.dart';
import '../../../models/models.dart';
import '../../../repository/repository.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  final AllegroAuthorizationRepository _allegroAuthorizationRepository;
  final UserRepository _userRepository;

  LoadingCubit({
    required AllegroAuthorizationRepository allegroAuthorizationRepository,
    required UserRepository userRepository,
  })  : _allegroAuthorizationRepository = allegroAuthorizationRepository,
        _userRepository = userRepository,
        super(const LoadingState());

  Future<void> checkToken() async {
    final user = _userRepository.currentUser;

    if (user.needToRefresh && !user.isNew) await _refreshToken();

    emit(
      state.copyWith(
        status: LoadingStatus.complete,
      ),
    );
  }

  Future<void> _refreshToken() async {
    try {
      final user = _userRepository.currentUser;

      final data = await _allegroAuthorizationRepository.refreshToken(
        clientId: user.clientId!,
        clientSecret: user.clientSecret!,
        refreshToken: user.refreshToken!,
      );

      if (data == null) {
        emit(
          state.copyWith(
            status: LoadingStatus.error,
            errorMessage: 'Error',
          ),
        );
        return;
      }

      await _updateUser(
        accessToken: data['access_token'],
        refreshToken: data['refresh_token'],
        expiresIn: data['expires_in'],
      );

      emit(
        state.copyWith(
          status: LoadingStatus.loaded,
        ),
      );
    } on AllegroApiException catch (e) {
      emit(
        state.copyWith(
          status: LoadingStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> _updateUser({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
  }) async {
    try {
      final user = _userRepository.currentUser.copyWith(
        accessToken: accessToken,
        refreshToken: refreshToken,
        refreshTokenDate: User.calculatetRefreshTokenDate(expiresIn: expiresIn),
      );

      await _userRepository.updateUser(user: user);
    } catch (_) {}
  }
}

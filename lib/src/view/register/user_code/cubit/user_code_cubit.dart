import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../exceptions/allegro_api/allegro_api.dart';
import '../../../../models/models.dart';
import '../../../../repository/repository.dart';

part 'user_code_state.dart';

class UserCodeCubit extends Cubit<UserCodeState> {
  final AllegroApiRepository _allegroApiRepository;
  final UserRepository _userRepository;
  final String clientId;
  final String clientSecret;
  final String deviceCode;

  UserCodeCubit({
    required this.clientId,
    required this.clientSecret,
    required this.deviceCode,
    required AllegroApiRepository allegroApiRepository,
    required UserRepository userRepository,
  })  : _allegroApiRepository = allegroApiRepository,
        _userRepository = userRepository,
        super(const UserCodeState());

  Future<void> getAccessToken() async {
    try {
      log('getAccessToken');
      emit(state.copyWith(status: UserCodeStatus.waiting));
      Future.doWhile(_getToken);
      emit(
        state.copyWith(
          status: UserCodeStatus.complete,
        ),
      );
    } on AllegroApiException catch (e) {
      emit(
        state.copyWith(
          status: UserCodeStatus.error,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<bool> _getToken() async {
    log('_getToken');
    await Future.delayed(const Duration(seconds: 5));
    final data = await _allegroApiRepository.getAuthToken(
      clientId: clientId,
      clientSecret: clientSecret,
      deviceCode: deviceCode,
    );

    if (data != null) {
      await _createUser(
        accessToken: data['access_token'],
        refreshToken: data['refresh_token'],
      );
      return false;
    }
    return true;
  }

  Future<void> _createUser({
    required String accessToken,
    required String refreshToken,
  }) async {
    log('_createUser');
    emit(
      state.copyWith(
        status: UserCodeStatus.createUser,
      ),
    );
    final user = User(
      isNew: false,
      clientId: clientId,
      clientSecret: clientSecret,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
    await _userRepository.createUser(user: user);
  }
}

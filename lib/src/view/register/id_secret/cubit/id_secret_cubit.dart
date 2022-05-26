import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../exceptions/exceptions.dart';
import '../../../../input/input.dart';
import '../../../../repository/repository.dart';
import '../../../../utils/json_decoder.dart';

part 'id_secret_state.dart';

class IdSecretCubit extends Cubit<IdSecretState> {
  final AllegroApiRepository _allegroApi;

  IdSecretCubit({required AllegroApiRepository allegroApi})
      : _allegroApi = allegroApi,
        super(const IdSecretState());

  void clientIdChanged({required String value}) {
    final text = TextInput.dirty(value);
    emit(
      state.copyWith(
        clientId: text,
        status: Formz.validate([text, state.clientSecret]),
      ),
    );
  }

  void clientSecretChanged({required String value}) {
    final text = TextInput.dirty(value);
    emit(
      state.copyWith(
        clientSecret: text,
        status: Formz.validate([text, state.clientId]),
      ),
    );
  }

  Future<void> authorize() async {
    try {
      if (!state.status.isValidated) return;

      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final body = await _allegroApi.appAuthorization(
        clientId: state.clientId.value,
        clientSecret: state.clientSecret.value,
      );

      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          deviceCode: body['device_code'],
          userCode: body['user_code'],
        ),
      );
    } on AllegroApiException catch (e) {
      printJson(e.message);
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e.message,
        ),
      );
    }
  }
}

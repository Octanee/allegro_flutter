import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../allegro_api/allegro_api.dart';
import '../../../exceptions/allegro_api/allegro_api.dart';
import '../../../input/text_input.dart';
import '../../../utils/json_decoder.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AllegroApi _allegroApi;

  late String deviceCode;
  late String userCode;
  late String verificationUri;

  RegisterCubit({required AllegroApi allegroApi})
      : _allegroApi = allegroApi,
        super(const RegisterState());

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

      deviceCode = body['device_code'];
      userCode = body['user_code'];
      verificationUri = body['verification_uri'];

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
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

  Future<void> getToken() async {
    try{
      
    }
  }
}

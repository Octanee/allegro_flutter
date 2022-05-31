part of 'id_secret_cubit.dart';

class IdSecretState extends Equatable {
  final TextInput clientId;
  final TextInput clientSecret;
  final FormzStatus status;
  final String? errorMessage;
  final String? deviceCode;
  final String? userCode;

  const IdSecretState({
    this.clientId = const TextInput.pure(),
    this.clientSecret = const TextInput.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.deviceCode,
    this.userCode,
  });

  @override
  List<Object?> get props => [clientId, clientSecret, status, errorMessage];

  IdSecretState copyWith({
    TextInput? clientId,
    TextInput? clientSecret,
    FormzStatus? status,
    String? errorMessage,
    String? deviceCode,
    String? userCode,
  }) {
    return IdSecretState(
      clientId: clientId ?? this.clientId,
      clientSecret: clientSecret ?? this.clientSecret,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      deviceCode: deviceCode ?? this.deviceCode,
      userCode: userCode ?? this.userCode,
    );
  }
}

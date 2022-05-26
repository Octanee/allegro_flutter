part of 'register_cubit.dart';

enum RegisterStatus {
  auth,
  token,
}

class RegisterState extends Equatable {
  final TextInput clientId;
  final TextInput clientSecret;
  final FormzStatus status;
  final String? errorMessage;

  const RegisterState({
    this.clientId = const TextInput.pure(),
    this.clientSecret = const TextInput.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [clientId, clientSecret, status, errorMessage];

  RegisterState copyWith({
    TextInput? clientId,
    TextInput? clientSecret,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      clientId: clientId ?? this.clientId,
      clientSecret: clientSecret ?? this.clientSecret,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

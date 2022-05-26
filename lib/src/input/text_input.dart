import 'package:formz/formz.dart';

enum TextInputValidationError { invalid }

class TextInput extends FormzInput<String, TextInputValidationError> {
  const TextInput.pure() : super.pure('');

  const TextInput.dirty([String value = '']) : super.dirty(value);

  @override
  TextInputValidationError? validator(String? value) {
    if (value == null) return TextInputValidationError.invalid;

    return value.isNotEmpty ? null : TextInputValidationError.invalid;
  }
}

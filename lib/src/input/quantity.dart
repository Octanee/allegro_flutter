import 'package:formz/formz.dart';

enum QuantityValidationError { invalid }

class Quantity extends FormzInput<int, QuantityValidationError> {
  const Quantity.pure() : super.pure(0);
  const Quantity.dirty([int value = 0]) : super.dirty(value);

  @override
  QuantityValidationError? validator(int value) {
    return (value >= 0) ? null : QuantityValidationError.invalid;
  }
}

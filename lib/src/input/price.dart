import 'package:formz/formz.dart';

enum PriceValidationError { invalid }

class Price extends FormzInput<double, PriceValidationError> {
  const Price.pure() : super.pure(0.0);
  const Price.dirty([double value = 0.0]) : super.dirty(value);

  @override
  PriceValidationError? validator(double value) {
    return (value > 0.0) ? null : PriceValidationError.invalid;
  }
}

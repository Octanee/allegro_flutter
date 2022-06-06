import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get textTheme => GoogleFonts.robotoTextTheme(theme.textTheme);
}

extension CustomColorsValue on ColorScheme {
  //Color get customGreen => const Color.fromARGB(255, 100, 200, 100);
}

extension TextStyleExtension on BuildContext {
  TextStyle? get displayLarge => textTheme.displayLarge;
  TextStyle? get displayMedium => textTheme.displayMedium;
  TextStyle? get displaySmall => textTheme.displaySmall;
  TextStyle? get headlineLarge => textTheme.headlineLarge;
  TextStyle? get headlineLargePrimary => textTheme.headlineLarge?.copyWith(
        color: colors.primary,
      );
  TextStyle? get headlineMedium => textTheme.headlineMedium;
  TextStyle? get headlineSmall => textTheme.headlineSmall;
  TextStyle? get titleLarge => textTheme.titleLarge;
  TextStyle? get titleLargePrimary => textTheme.titleLarge?.copyWith(
        color: colors.primary,
      );
  TextStyle? get titleMedium => textTheme.titleMedium;
  TextStyle? get titleMediumPrimary => textTheme.titleMedium?.copyWith(
        color: colors.primary,
      );
  TextStyle? get titleSmall => textTheme.titleSmall;
  TextStyle? get labelLarge => textTheme.labelLarge;
  TextStyle? get labelMedium => textTheme.labelMedium;
  TextStyle? get labelSmall => textTheme.labelSmall;
  TextStyle? get bodyLarge => textTheme.bodyLarge;
  TextStyle? get bodyMedium => textTheme.bodyMedium;
  TextStyle? get bodySmall => textTheme.bodySmall;
}

extension PaddingExtension on BuildContext {
  double get paddingSmall => 4.0;
  double get paddingMedium => 8.0;
  double get paddingLarge => 16.0;
  double get paddingXLarge => 24.0;
}

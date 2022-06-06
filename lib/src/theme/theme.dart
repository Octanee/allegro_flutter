import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData theme({
    required Color seedColor,
    required Brightness brightness,
  }) {
    return brightness == Brightness.light
        ? _light(seedColor: seedColor)
        : _dark(seedColor: seedColor);
  }

  ThemeData _dark({required Color seedColor}) {
    final colors = _colors(brightness: Brightness.dark, seedColor: seedColor);
    final darkTheme = _customTheme(base: ThemeData.dark(), colors: colors);
    return darkTheme;
  }

  ThemeData _light({required Color seedColor}) {
    final colors = _colors(brightness: Brightness.light, seedColor: seedColor);
    final lightTheme = _customTheme(base: ThemeData.light(), colors: colors);
    return lightTheme;
  }

  ThemeData _customTheme({
    required ThemeData base,
    required ColorScheme colors,
  }) {
    final custom = base.copyWith(
      useMaterial3: true,
      colorScheme: colors,
      appBarTheme: _appBarTheme(colors: colors),
      iconTheme: _iconTheme(colors: colors),
    );

    return custom;
  }

  ColorScheme _colors({
    required Brightness brightness,
    required Color seedColor,
  }) {
    final colors = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );
    return colors;
  }

  AppBarTheme _appBarTheme({required ColorScheme colors}) {
    return AppBarTheme(
      //backgroundColor: colors.primary,
      iconTheme: IconThemeData(color: colors.primary),
    );
  }

  IconThemeData _iconTheme({required ColorScheme colors}) {
    return IconThemeData(color: colors.primary);
  }
}

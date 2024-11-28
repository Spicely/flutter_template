import 'package:flutter/material.dart';

part 'extend_colors.dart';

class ThemeCustom {
  static ThemeData light = ThemeData(
    extensions: const <ThemeExtension<ExtendColors>>[ExtendColors.light],
  );

  static ThemeData dark = ThemeData(
    extensions: const <ThemeExtension<ExtendColors>>[ExtendColors.dark],
  );
}

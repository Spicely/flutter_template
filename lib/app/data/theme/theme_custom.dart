import 'package:flutter/material.dart';

part 'extend_colors.dart';

/////////////////////////////////////////////////////////////////////////
///
/// All rights reserved.
///
/// author: Spicely
///
/// Summary: 自定义主题
///
/// Date: 2024年11月28日 16:42:41 Thursday
///
//////////////////////////////////////////////////////////////////////////

class ThemeCustom {
  static ThemeData light = ThemeData(
    extensions: const <ThemeExtension<ExtendColors>>[ExtendColors.light],
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
      accentColor: Colors.blueAccent,
      backgroundColor: Colors.white,
      errorColor: Colors.red,
    ),
  );

  static ThemeData dark = ThemeData(
    extensions: const <ThemeExtension<ExtendColors>>[ExtendColors.dark],
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
      accentColor: Colors.blueAccent,
      backgroundColor: Colors.white,
      errorColor: Colors.red,
    ),
  );
}

// ignore_for_file: library_private_types_in_public_api

part of 'theme_custom.dart';

/////////////////////////////////////////////////////////////////////////
///
/// All rights reserved.
///
/// author: Spicely
///
/// Summary: 扩展自定义颜色
///
/// Date: 2024年11月28日 16:42:23 Thursday
///
//////////////////////////////////////////////////////////////////////////
class ExtendTheme extends ThemeExtension<ExtendTheme> {
  /// 主题色
  final Color themeColor;

  final Color gray;

  final Color subColor;

  const ExtendTheme({
    required this.themeColor,
    required this.gray,
    required this.subColor,
  });

  @override
  ThemeExtension<ExtendTheme> copyWith() {
    return ExtendTheme(
      themeColor: themeColor,
      gray: gray,
      subColor: subColor,
    );
  }

  @override
  ThemeExtension<ExtendTheme> lerp(ThemeExtension<ExtendTheme> other, double t) {
    if (other is! ExtendTheme) {
      return this;
    }
    return ExtendTheme(
      themeColor: Color.lerp(themeColor, other.themeColor, t)!,
      gray: Color.lerp(gray, other.gray, t)!,
      subColor: Color.lerp(subColor, other.subColor, t)!,
    );
  }

  static const light = ExtendTheme(
    themeColor: Colors.white,
    gray: Color.fromRGBO(32, 31, 41, 1),
    subColor: Color.fromRGBO(178, 178, 178, 1),
  );

  static const dark = ExtendTheme(
    themeColor: Color.fromRGBO(32, 31, 41, 1),
    gray: Color.fromRGBO(52, 51, 61, 1),
    subColor: Color.fromRGBO(178, 178, 178, 1),
  );
}

class _ExtendTheme {
  final ExtendTheme? extendColors;

  _ExtendTheme._(this.extendColors);

  Color? get themeColor => extendColors?.themeColor;

  Color? get gray => extendColors?.gray;

  Color? get subColor => extendColors?.subColor;

  BorderRadius borderRadius = BorderRadius.circular(8);
}

/// 扩展BuildContext
extension BuildContextExtendColors on BuildContext {
  _ExtendTheme get extendTheme => _ExtendTheme._(Theme.of(this).extension<ExtendTheme>());
}

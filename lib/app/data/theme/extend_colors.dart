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

@immutable
class ExtendColors extends ThemeExtension<ExtendColors> {
  /// 主题色
  final Color themeColor;

  final Color gray;

  final Color subColor;

  const ExtendColors({
    required this.themeColor,
    required this.gray,
    required this.subColor,
  });

  @override
  ThemeExtension<ExtendColors> copyWith() {
    return ExtendColors(
      themeColor: themeColor,
      gray: gray,
      subColor: subColor,
    );
  }

  @override
  ThemeExtension<ExtendColors> lerp(ThemeExtension<ExtendColors> other, double t) {
    if (other is! ExtendColors) {
      return this;
    }
    return ExtendColors(
      themeColor: Color.lerp(themeColor, other.themeColor, t)!,
      gray: Color.lerp(gray, other.gray, t)!,
      subColor: Color.lerp(subColor, other.subColor, t)!,
    );
  }

  static const light = ExtendColors(
    themeColor: Colors.white,
    gray: Color.fromRGBO(32, 31, 41, 1),
    subColor: Color.fromRGBO(178, 178, 178, 1),
  );

  static const dark = ExtendColors(
    themeColor: Color.fromRGBO(32, 31, 41, 1),
    gray: Color.fromRGBO(52, 51, 61, 1),
    subColor: Color.fromRGBO(178, 178, 178, 1),
  );
}

import 'package:flutter/material.dart';

import '../theme/theme_custom.dart';

/////////////////////////////////////////////////////////////////////////
///
/// All rights reserved.
///
/// author: Spicely
///
/// Summary: 主题混入获取
///
/// Date: 2024年11月28日 16:41:05 Thursday
///
//////////////////////////////////////////////////////////////////////////

mixin ThemeMixin {
  Color? themeColor(BuildContext context) => Theme.of(context).extension<ExtendColors>()?.themeColor;

  Color? primaryColor(BuildContext context) => Theme.of(context).colorScheme.primary;

  Color? gray(BuildContext context) => Theme.of(context).extension<ExtendColors>()?.gray;

  Color? subColor(BuildContext context) => Theme.of(context).extension<ExtendColors>()?.subColor;

  BorderRadius get borderRadius => BorderRadius.circular(12);
}

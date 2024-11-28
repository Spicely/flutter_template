import 'dart:ui';

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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme_custom.dart';

mixin ThemeMixin {
  Color? get themeColor => Get.context?.theme.extension<ExtendColors>()?.themeColor;

  Color? get primaryColor => Get.context?.theme.primaryColor;

  Color? get gray => Get.context?.theme.extension<ExtendColors>()?.gray;

  Color? get subColor => Get.context?.theme.extension<ExtendColors>()?.subColor;
}

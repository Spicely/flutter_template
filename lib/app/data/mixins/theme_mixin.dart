import 'dart:ui';

/*
 * Summary: 主题色mixin
 * Created Date: 2023-04-05 10:46:04
 * Author: Spicely
 * -----
 * Last Modified: 2023-07-16 13:19:09
 * Modified By: Spicely
 * -----
 * Copyright (c) 2023 Spicely Inc.
 * 
 * May the force be with you.
 * -----
 * HISTORY:
 * Date      	By	Comments
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme_custom.dart';

mixin ThemeMixin {
  Color? get themeColor => Get.context?.theme.extension<ExtendColors>()?.themeColor;

  Color? get primaryColor => Get.context?.theme.primaryColor;

  Color? get gray => Get.context?.theme.extension<ExtendColors>()?.gray;

  Color? get subColor => Get.context?.theme.extension<ExtendColors>()?.subColor;
}

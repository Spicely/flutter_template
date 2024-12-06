// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:app_installer/app_installer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../components/dialog/upgrade_dialog/upgrade_dialog.dart';
import '../../components/dialog/upgrade_dialog/upgrade_dialog_model.dart';
import '../manager/compress_manager/compress_manager.dart';
import '../manager/isar_manager/isar_manager.dart';
import '../manager/system_manager/system_manager.dart';
import '../mixins/permission_mixin.dart';

part '_config.dart';
part '_plugins.dart';
part '_upgrade.dart';

class _Utils {
  _Utils._();

  _Plugins plugins = _Plugins._();

  _Config config = _Config._();

  _Upgrade upgrade = _Upgrade._();

  Future<void> init() async {
    await config.init();
    await plugins.init();
  }
}

final utils = _Utils._();

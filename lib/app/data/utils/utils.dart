import 'dart:io';

import 'package:app_installer/app_installer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
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
part '_error.dart';
part '_plugins.dart';
part '_upgrade.dart';

class _Utils {
  _Utils._();

  _Plugins plugins = _Plugins._();

  _Config config = _Config._();

  _Upgrade upgrade = _Upgrade._();

  _Error error = _Error._();

  Future<void> init() async {
    await config.init();
    await plugins.init();
  }

  Logger logger = Logger(printer: PrettyPrinter(methodCount: 2, errorMethodCount: 8, lineLength: 120, colors: true, printEmojis: true));

  /// 异常捕获
  Future<void> exceptionCapture(Function() cb, {void Function(DioException)? dioError, void Function(Object)? error}) async {
    try {
      await cb();
    } on DioException catch (e) {
      dioError != null ? dioError.call(e) : this.error.dioError(e);
    } catch (e) {
      error != null ? error.call(e) : this.error.error(e);
    }
  }
}

final utils = _Utils._();

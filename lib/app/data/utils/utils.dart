import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:logger/logger.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../env/env.dart';
import '../../components/dialog/upgrade_dialog/upgrade_dialog.dart';
import '../models/upgrade_model.dart';
import '../manager/compress_manager/compress_manager.dart';
import '../manager/isar_manager/isar_manager.dart';
import '../manager/system_manager/system_manager.dart';
import '../mixins/permission_mixin.dart';

part '_apis.dart';
part '_config.dart';
part '_error.dart';
part '_tools/_http.dart';
part '_plugins.dart';
part '_tools/_tools.dart';
part '_tools/_upgrade.dart';
part '_extend_upgrade.dart';

class _Utils {
  _Utils._();

  final _Tools tools = _Tools._();

  final _ExtendUpgrade upgrade = _ExtendUpgrade._();

  final _Http _http = _Http._(debug: kDebugMode);

  final Logger logger = Logger(printer: PrettyPrinter(methodCount: 2, errorMethodCount: 8, lineLength: 120, colors: true, printEmojis: true));

  final _Config config = _Config._();

  final _Error error = _Error._();

  final _Plugins plugins = _Plugins._();

  late _Apis apis = _Apis._(_http);

  Future<void> init() async {
    await config.init();
    await plugins.init();
    await tools.init();
  }
}

final utils = _Utils._();

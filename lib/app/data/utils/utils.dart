import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../manager/compress_manager/compress_manager.dart';
import '../manager/isar_manager/isar_manager.dart';
import '../manager/system_manager/system_manager.dart';

part 'config.dart';
part 'plugins.dart';

class Utils {
  Utils._();

  Plugins plugins = Plugins._();

  Config config = Config._();

  Future<void> init() async {
    await config.init();
    await plugins.init();
  }
}

Utils utils = Utils._();

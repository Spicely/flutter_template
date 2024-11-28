import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../manager/compress_manager/compress_manager.dart';
import '../manager/isar_manager/isar_manager.dart';
import '../manager/system_manager/system_manager.dart';
/////////////////////////////////////////////////////////////////////////
///
/// All rights reserved.
///
/// author: Spicely
///
/// Summary: 配置文件
///
/// Date: 2024年11月28日 22:23:07 Thursday
///
//////////////////////////////////////////////////////////////////////////

class Config {
  static bool _isInit = false;

  static late final Directory directory;

  /// 压缩输出路径
  static late String compressedOutputPath;

  static Future<void> init() async {
    if (_isInit) return;
    _isInit = true;
    directory = await getApplicationSupportDirectory();
    compressedOutputPath = p.join(directory.path, 'compress');
    await Directory(compressedOutputPath).create(recursive: true);
    await IsarManager.init(directory.path);
    await CompressManager.init(CompressParams(outputDir: compressedOutputPath));
    await SystemManager.init();
    debugPrint(directory.path);
  }
}

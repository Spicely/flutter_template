import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

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

  /// 版本号
  static String version = '';

  /// 应用名称
  static String appName = 'Template';

  static Future<void> init() async {
    if (_isInit) return;
    _isInit = true;
    directory = await getApplicationSupportDirectory();
    compressedOutputPath = p.join(directory.path, 'compress');
    await Directory(compressedOutputPath).create(recursive: true);
    await IsarManager.init(directory.path);
    await CompressManager.init(CompressParams(outputDir: compressedOutputPath));
    await SystemManager.init();
    await _getVersion();
    debugPrint(directory.path);
  }

  /// 获取版本号
  static Future<void> _getVersion() async {
    // 获取包信息
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // 获取版本号和构建号
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    version = '$version+$buildNumber';
  }
}

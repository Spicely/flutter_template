part of '../utils.dart';

/////////////////////////////////////////////////////////////////////////
///
/// All rights reserved.
///
/// author: Spicely
///
/// Summary: 工具类
///
/// Date: 2024年12月13日 09:34:04 Friday
///
//////////////////////////////////////////////////////////////////////////

class _Tools {
  _Tools._();

  Future<void> init() async {
    await _getVersion();
  }

  /// 异常捕获
  Future<void> exceptionCapture(Function() cb, {void Function(DioException)? dioError, void Function(Object)? error}) async {
    try {
      await cb();
    } on DioException catch (e) {
      dioError != null ? dioError.call(e) : utils.error.dioError(e);
    } catch (e) {
      error != null ? error.call(e) : utils.error.error(e);
    }
  }

  /// 版本号
  String version = '';

  /// 是否是桌面
  bool isDesktop = (Platform.isMacOS || Platform.isWindows || Platform.isLinux) ? true : false;

  /// 是否是移动端
  bool isMobile = (Platform.isAndroid || Platform.isIOS) ? true : false;

  /// 获取版本号
  Future<void> _getVersion() async {
    // 获取包信息
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // 获取版本号和构建号
    version = packageInfo.version;
  }

  String get platform {
    if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    } else if (Platform.isMacOS) {
      return 'macOS';
    } else if (Platform.isFuchsia) {
      return 'fuchsia';
    } else if (Platform.isLinux) {
      return 'linux';
    } else {
      return 'windows';
    }
  }

  String getSecrecyMobile(String mobile) {
    if (mobile.length < 11) return mobile;
    return mobile.replaceRange(3, 7, '****');
  }

  Future<double> _getTotalSizeOfFilesInDir(FileSystemEntity file) async {
    if (file is File && file.existsSync()) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory && file.existsSync()) {
      List children = file.listSync();
      double total = 0;
      if (children.isNotEmpty) {
        for (final FileSystemEntity child in children) {
          total += await _getTotalSizeOfFilesInDir(child);
        }
      }

      return total;
    }
    return 0;
  }

  /// 获取缓存大小
  Future<String> getCacheSize() async {
    final tempDir = await getTemporaryDirectory();
    double size = await _getTotalSizeOfFilesInDir(tempDir);

    const List<String> unitArr = ['B', 'KB', 'MB', 'GB', 'TB'];
    int index = 0;
    while (size > 1024) {
      index++;
      size = size / 1024;
    }
    String v = size.toStringAsFixed(2);
    return v + unitArr[index];
  }

  /// 判断为null 或者空字符串
  bool isEmpty(dynamic data) {
    switch (data) {
      case int _ when data == 0:
        return true;
      case String _ when data.isEmpty:
        return true;
      default:
        return false;
    }
  }

  /// 判断为null 或者空字符串
  bool isNotEmpty(String? data) {
    return data != null && data.isNotEmpty;
  }

  /// 判断包含数字/字母
  bool validCharacters(String str, {int min = 6, int max = 18}) {
    if (str.length < min || str.length > max) {
      return false;
    }
    final validCharacter = RegExp('^(?![0-9]+\$)(?![a-zA-Z]+\$)[0-9A-Za-z]');
    return validCharacter.hasMatch(str);
  }

  /// 验证手机号
  bool isPhone(String str) {
    return RegExp('^[1][3,4,5,6,7,8,9][0-9]{9}\$').hasMatch(str);
  }

  /// 数字超过10000转万
  ///
  /// [unit] 单位
  String formatNumber(int number, {String unit = '万'}) {
    if (number < 10000) {
      return number.toString();
    } else {
      return (number / 10000).toStringAsFixed(1) + unit;
    }
  }
}

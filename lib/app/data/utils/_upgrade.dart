part of 'utils.dart';

/////////////////////////////////////////////////////////////////////////
///
/// All rights reserved.
///
/// author: Spicely
///
/// Summary: 应用更新
///
/// Date: 2024年12月09日 22:44:35 Monday
///
//////////////////////////////////////////////////////////////////////////

class _Upgrade with PermissionMixin {
  bool _isUpgrade = false;

  bool _idDownloading = false;

  /// 更新APP
  void inspect() {
    if (_isUpgrade) return;
    _isUpgrade = true;
    utils.exceptionCapture(() async {
      UpgradeModel model = await checkUpgrade();
      if (model.isUpgrade) {
        if (model.isSilentUpgrade) {
          upgrade(model);
        } else {
          Get.dialog(UpgradeDialog(data: model));
        }
      }
    });
  }

  /// 返回更新信息
  Future<UpgradeModel> checkUpgrade() async {
    return UpgradeModel();
  }

  /// 开始更新
  void upgrade(UpgradeModel data) {
    if (_idDownloading) return;
    _idDownloading = true;

    if (Platform.isAndroid) {
      _downloadFile(data);
    } else {
      _install(data.fileUrl);
    }
  }

  /// 下载apk
  void _downloadFile(UpgradeModel data) async {
    try {
      /// 保存地址
      String directory = p.join(utils.config.directory.path, 'apk');
      Directory(directory).createSync(recursive: true);

      /// 文件名
      String filename = p.basename(data.fileUrl);

      /// 判断文件是否存在
      String savePath = p.join(directory, filename);
      if (File(savePath).existsSync()) {
        await _install(savePath);
        return;
      }

      /// 开始下载
      await Dio().download(
        data.fileUrl,
        savePath,
        onReceiveProgress: (count, total) {
          print((count / total * 100).toStringAsFixed(2));
        },
      );
      await _install(savePath);
    } catch (e) {
      _isUpgrade = false;
      _idDownloading = false;
      utils.logger.e('下载失败,请检查网络连接');
    }
  }

  /// 安装应用
  Future<void> _install(String filePath) async {
    await requestStoragePermission();
    switch (Platform.operatingSystem) {
      case 'android':
        await requestInstallPermission();
        await OpenFile.open(filePath, type: 'application/vnd.android.package-archive');
        break;

      case 'ios':
        Uri uri = Uri.parse('https://apps.apple.com/cn/app/id$filePath');
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          utils.logger.e('无法打开App Store链接,请联系客服');
        }
        break;
    }

    _isUpgrade = false;
    _idDownloading = false;
  }
}

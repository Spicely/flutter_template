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
  _Upgrade._();

  bool _isUpgrade = false;

  late UpgradeDialogModel _dialogModel;

  /// 检测更新
  void checkUpgrade(UpgradeDialogModel model) {
    _dialogModel = model;
    if (!model.isUpgrade) return;
    Get.dialog(UpgradeDialog(data: model));
  }

  void install() {
    _upgrade();
  }

  void _upgrade() {
    if (_isUpgrade) return;
    _isUpgrade = true;

    if (Platform.isAndroid) {
      _downloadFile();
    } else {
      print('123123');
      // _installApk(_dialogModel.fileUrl);
    }
  }

  /// 下载apk
  void _downloadFile() async {
    /// 保存地址
    String directory = p.join(utils.config.directory.path, 'apk');
    Directory(directory).createSync(recursive: true);

    /// 文件名
    String filename = p.basename(_dialogModel.fileUrl);

    /// 判断文件是否存在
    String savePath = p.join(directory, filename);
    if (File(savePath).existsSync()) {
      await _install(savePath);
      return;
    }

    /// 开始下载
    await Dio().download(
      _dialogModel.fileUrl,
      savePath,
      onReceiveProgress: (count, total) {
        print((count / total * 100).toStringAsFixed(2));
      },
    );
    await _install(savePath);
  }

  /// 安装应用
  Future<void> _install(String filePath) async {
    await requestStoragePermission();
    switch (Platform.operatingSystem) {
      case 'android':
      case 'ios':
        await AppInstaller.installApk(filePath);
        break;
    }

    _isUpgrade = false;
  }
}

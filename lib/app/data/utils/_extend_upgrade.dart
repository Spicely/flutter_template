part of 'utils.dart';

class _ExtendUpgrade extends _Upgrade {
  _ExtendUpgrade._();

  @override
  Future<UpgradeModel> checkUpgrade() async {
    // try {
    //   GlobalController g = Get.find<GlobalController>();
    //   Map<String, dynamic> res = await utils.apis.getLatestVersion(g.config.channel, g.config.projectId);

    //   return UpgradeModel(
    //     isUpgrade: utils.tools.isNotEmpty(res['versionCode']),
    //     isForceUpgrade: res['isForce'] == 1,
    //     isSilentUpgrade: res['isRenew'] == 1,
    //     versionCode: res['versionCode'],
    //     fileUrl: res['fileUrl'],
    //     versionDesc: res['notice'],
    //   );
    // } catch (e) {
    //   utils.logger.e(e);
    return UpgradeModel();
    // }
  }

  @override
  void noUpgradeToast() {
    // EasyLoading.showToast('已经是最新版本了');
  }
}

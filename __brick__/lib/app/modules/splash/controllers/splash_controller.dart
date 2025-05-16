import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../components/dialog/privacy_dialog/privacy_dialog.dart';
import '../../../controllers/global_controller.dart';
import '../../../data/manager/isar_manager/isar_manager.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  GlobalController g = Get.find<GlobalController>();

  @override
  void onReady() {
    super.onReady();
    if (g.config.isAgreement) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed(Routes.HOME);
      });
    } else {
      Get.dialog(PrivacyDialog(privacyUrl: 'https://www.google.com', userAgreementUrl: 'https://www.google.com', onAgree: onAgree));
    }
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
  }

  @override
  void onClose() {
    super.onClose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  }

  void onAgree() {
    Get.offAllNamed(Routes.HOME);
    g.config.isAgreement = true;
    IsarManager.configManager.save(g.config);
  }
}

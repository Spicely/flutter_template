import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../data/utils/utils.dart';

class UpgradeDialog extends StatelessWidget {
  const UpgradeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: !utils.upgrade.data.value.isForceUpgrade,
        child: CupertinoAlertDialog(
          title: Text(S.current.upgrade),
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [Text(utils.upgrade.data.value.versionDesc)],
                  ),
                ),
                if (utils.upgrade.isDownloading.value) LinearProgressIndicator(value: utils.upgrade.progress.value),
              ],
            ),
          ),
          actions: <Widget>[
            if (!utils.upgrade.data.value.isForceUpgrade)
              CupertinoDialogAction(
                onPressed: Get.back,
                child: Text(S.current.cancel, style: const TextStyle(color: Colors.white)),
              ),
            CupertinoDialogAction(
              onPressed: utils.upgrade.upgrade,
              child: Text(S.current.confirm, style: const TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}

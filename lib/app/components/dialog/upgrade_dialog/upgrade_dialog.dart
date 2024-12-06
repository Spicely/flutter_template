import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../data/utils/utils.dart';
import 'upgrade_dialog_model.dart';

class UpgradeDialog extends StatelessWidget {
  final UpgradeDialogModel data;

  const UpgradeDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: CupertinoAlertDialog(
        title: Text(S.current.upgrade),
        content: SizedBox(
          height: 120,
          child: ListView(
            children: [
              Text(data.versionDesc),
            ],
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: Get.back,
            child: Text(S.current.cancel, style: const TextStyle(color: Colors.black)),
          ),
          CupertinoDialogAction(
            onPressed: utils.upgrade.install,
            child: Text(S.current.confirm, style: const TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}

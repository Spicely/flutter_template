import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../gen/assets.gen.dart';
import '../../../data/theme/theme_custom.dart';
import '../../../data/utils/utils.dart';
import '../../theme_button/theme_button.dart';

class UpgradeDialog extends StatelessWidget {
  const UpgradeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: !utils.upgrade.data.value.isForceUpgrade,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 320.w,
                height: 413.h,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Assets.components.upgradeBg.path), fit: BoxFit.fitHeight),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w).copyWith(top: 70.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('发现新版本', style: TextStyle(fontSize: 26.sp, color: Colors.black)),
                      Text('v${utils.upgrade.data.value.versionCode}', style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                      64.verticalSpace,
                      Text('更新内容', style: TextStyle(fontSize: 16.sp, color: context.eTheme.subColor)),
                      2.verticalSpace,
                      SizedBox(
                        height: 111.h,
                        child: ListView(
                          children: [
                            Text(utils.upgrade.data.value.versionDesc, style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                          ],
                        ),
                      ),
                      Obx(
                        () => utils.upgrade.isDownloading.value
                            ? Column(
                                children: [
                                  Text(
                                    '${(utils.upgrade.progress.value * 100).toStringAsFixed(1)}%',
                                    style: TextStyle(fontSize: 10.sp, color: Colors.grey[600], fontWeight: FontWeight.bold),
                                  ),
                                  8.verticalSpace,
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: LinearProgressIndicator(
                                      value: utils.upgrade.progress.value,
                                      minHeight: 8.h,
                                      borderRadius: BorderRadius.circular(6),
                                      backgroundColor: Colors.grey[300],
                                      color: context.theme.primaryColor,
                                    ),
                                  ),
                                  10.verticalSpace,
                                  Text('下载中，请稍后', style: TextStyle(fontSize: 16.sp, color: Colors.grey)),
                                ],
                              )
                            : ThemeButton(
                                height: 54.h,
                                onPressed: utils.upgrade.upgrade,
                                child: Text('立即更新', style: TextStyle(fontSize: 18.sp, color: Colors.black)),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              17.verticalSpace,
              Center(
                child: GestureDetector(
                  onTap: () {
                    utils.upgrade.cancelUpgrade();
                    Get.close();
                  },
                  child: Assets.components.upgradeClose.image(width: 26.w, height: 26.h),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

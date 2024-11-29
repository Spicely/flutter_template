import 'package:permission_handler/permission_handler.dart';

/////////////////////////////////////////////////////////////////////////
///
/// All rights reserved.
///
/// author: Spicely
///
/// Summary: 权限获取
///
/// Date: 2024年11月28日 22:12:27 Thursday
///
//////////////////////////////////////////////////////////////////////////

mixin PermissionMixin {
  /// 获取定位权限
  Future<void> requestLocationPermission({Function? callback}) async {
    if (await Permission.location.request().isGranted) {
      callback?.call();
    } else {
      // openAppSettings();
    }
  }
}

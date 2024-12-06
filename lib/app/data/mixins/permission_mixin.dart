import 'package:permission_handler/permission_handler.dart';

import '../enums/permission_type.dart';
import '../exception/permission_exception.dart';

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
  Future<void> requestLocationPermission() async {
    if (await Permission.location.request().isGranted) {
      return;
    }
    throw PermissionException(PermissionType.location, '定位权限获取失败');
  }

  /// 获取相机权限
  Future<void> requestCameraPermission() async {
    if (await Permission.camera.request().isGranted) {
      return;
    }
    throw PermissionException(PermissionType.camera, '相机权限获取失败');
  }

  /// 获取麦克风权限
  Future<void> requestMicrophonePermission() async {
    if (await Permission.microphone.request().isGranted) {
      return;
    }
    throw PermissionException(PermissionType.microphone, '麦克风权限获取失败');
  }

  /// 获取存储权限
  Future<void> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      return;
    }
    throw PermissionException(PermissionType.storage, '存储权限获取失败');
  }
}

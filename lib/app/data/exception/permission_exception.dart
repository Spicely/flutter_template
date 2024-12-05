import '../enums/permission_type.dart';

class PermissionException implements Exception {
  final PermissionType type;

  final String message;

  PermissionException(this.type, this.message);
}

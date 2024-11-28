part of '../system_manager.dart';

class SystemFileEntity {
  final String name;

  final String path;

  final SystemFileEntityType type;

  /// 后缀
  final String ext;

  final SystemFileType fileType;

  /// 子文件
  List<SystemFileEntity> children;

  /// 预览图
  List<SystemFileEntity> preview;

  SystemFileEntity({
    required this.name,
    required this.path,
    required this.type,
    required this.ext,
    required this.fileType,
    this.children = const [],
    this.preview = const [],
  });
}

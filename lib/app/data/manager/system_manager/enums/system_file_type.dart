part of '../system_manager.dart';

enum SystemFileType {
  image,

  video,

  audio,

  document,

  other;

  /// 静态方法：根据文件后缀返回对应的 SystemFileType
  static SystemFileType fromExtension(String extension) {
    // 将后缀转换为小写，便于匹配
    final ext = extension.toLowerCase();

    if (['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(ext)) {
      return SystemFileType.image;
    } else if (['mp4', 'avi', 'mkv', 'mov', 'flv'].contains(ext)) {
      return SystemFileType.video;
    } else if (['mp3', 'wav', 'aac', 'flac', 'ogg'].contains(ext)) {
      return SystemFileType.audio;
    } else if (['pdf', 'doc', 'docx', 'txt', 'xls', 'xlsx', 'ppt', 'pptx'].contains(ext)) {
      return SystemFileType.document;
    } else {
      return SystemFileType.other;
    }
  }
}

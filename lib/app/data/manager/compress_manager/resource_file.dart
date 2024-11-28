part of 'compress_manager.dart';

class ResourceFile {
  final String id;

  final FileType fileType;

  final String fileName;

  final String path;

  /// 后缀
  final String ext;

  /// 视频预览图
  File? videoPreview;

  ResourceFile({
    required this.id,
    required this.fileType,
    required this.fileName,
    required this.path,
    required this.ext,
    this.videoPreview,
  });

  factory ResourceFile.form(String path) {
    final ext = path.split('.').last.toLowerCase();
    return ResourceFile(
      id: UniqueKey().toString(),
      fileType: switch (ext) {
        'jpg' || 'jpeg' || 'png' || 'gif' || 'bmp' || 'webp' || 'svg' => FileType.image,
        'mp4' || 'mov' || 'avi' || 'mkv' || 'flv' || 'wmv' => FileType.video,
        'mp3' || 'wav' || 'aac' || 'ogg' || 'flac' => FileType.audio,
        _ => FileType.other,
      },
      fileName: p.basename(path),
      path: path,
      ext: ext,
    );
  }
}

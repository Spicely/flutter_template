part of 'compress_manager.dart';

mixin CompressListener {
  /// 接收压缩
  void onCompressWait(CompressInfo info) {}

  /// 压缩开始
  void onCompressStart(CompressInfo info) {}

  /// 压缩完成
  void onCompressComplete(CompressInfo info) {}

  /// 压缩失败
  void onCompressFail(CompressInfo info) {}
}

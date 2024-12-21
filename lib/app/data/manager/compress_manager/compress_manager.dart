import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:simple_native_image_compress/simple_native_image_compress.dart';
import 'package:video_compress/video_compress.dart';

part 'compress_listener.dart';
part 'file_type.dart';
part 'resource_file.dart';

class CompressParams {
  final String outputDir;

  /// 任务数量
  final int count;

  CompressParams({required this.outputDir, this.count = 5});
}

class _IsolateTaskData<T> {
  final SendPort sendPort;

  final T data;

  final RootIsolateToken? rootIsolateToken;

  _IsolateTaskData(this.sendPort, this.data, this.rootIsolateToken);
}

enum CompressStatus {
  none,

  /// 完成
  success,

  /// 失败
  fail,

  /// 压缩中
  compressing,
}

class CompressInfo {
  CompressStatus status;

  final ResourceFile data;

  MediaInfo? mediaInfo;

  CompressInfo({
    this.status = CompressStatus.none,
    required this.data,
    this.mediaInfo,
  });
}

class CompressManager {
  /// 线程通知
  static late SendPort _sendPort;

  static List<CompressInfo> tasks = [];

  static late Isolate isolate;

  static final ObserverList<CompressListener> _listeners = ObserverList<CompressListener>();

  static List<CompressListener> get listeners {
    final List<CompressListener> localListeners = List<CompressListener>.from(_listeners);
    return localListeners;
  }

  static bool get hasListeners {
    return _listeners.isNotEmpty;
  }

  static void addListener(CompressListener listener) {
    _listeners.add(listener);
  }

  static void removeListener(CompressListener listener) {
    _listeners.remove(listener);
  }

  /// 事件触发
  static void _onEvent(Function(CompressListener) callback) {
    for (CompressListener listener in listeners) {
      if (!_listeners.contains(listener)) {
        return;
      }
      callback(listener);
    }
  }

  static Future<void> init(CompressParams params) async {
    ReceivePort port = ReceivePort();
    RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;

    isolate = await Isolate.spawn(
      _isolateEntry,
      _IsolateTaskData<CompressParams>(port.sendPort, params, rootIsolateToken),
    );

    Completer completer = Completer();
    port.listen((msg) {
      if (msg is CompressInfo) {
        switch (msg.status) {
          case CompressStatus.none:
            _onEvent((v) => v.onCompressWait(msg));
            break;
          case CompressStatus.compressing:
            _onEvent((v) => v.onCompressStart(msg));
            break;
          case CompressStatus.success:
            _onEvent((v) => v.onCompressComplete(msg));
            break;
          case CompressStatus.fail:
            _onEvent((v) => v.onCompressFail(msg));
            break;
        }
      }
      if (msg is SendPort) {
        _sendPort = msg;
        completer.complete();
        return;
      }
    });
    return await completer.future;
  }

  static Future<void> _isolateEntry(_IsolateTaskData<CompressParams> task) async {
    if (task.rootIsolateToken != null) {
      BackgroundIsolateBinaryMessenger.ensureInitialized(task.rootIsolateToken!);
    }
    await NativeImageCompress.init();
    final ReceivePort receivePort = ReceivePort();

    receivePort.listen((msg) async {
      try {
        if (msg is ResourceFile) {
          CompressInfo compressInfo = CompressInfo(data: msg);

          switch (msg.fileType) {
            case FileType.image:
              tasks.add(compressInfo);
              task.sendPort.send(compressInfo);
              _compressImage(msg, task.data, compressInfo, task.sendPort);
              break;
            case FileType.video:
              if (Platform.isWindows || Platform.isLinux) return;
              tasks.add(compressInfo);
              File file = await VideoCompress.getFileThumbnail(msg.path);
              compressInfo.data.videoPreview = file;
              task.sendPort.send(compressInfo);
              _compressVideo(msg, task.data, compressInfo, task.sendPort);
              break;
            default:
          }
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    task.sendPort.send(receivePort.sendPort);
  }

  /// 添加任务
  static void add(String filePath) {
    _sendPort.send(ResourceFile.form(filePath));
  }

  /// 更新任务信息
  static void _update(CompressInfo compressInfo) {
    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].data.id == compressInfo.data.id) {
        tasks[i] = compressInfo;
        break;
      }
    }
  }

  /// 压缩图片
  static void _compressImage(ResourceFile resourceFile, CompressParams data, CompressInfo compressInfo, SendPort sendPort) async {
    try {
      compressInfo.status = CompressStatus.compressing;
      _update(compressInfo);
      sendPort.send(compressInfo);
      Uint8List bytes = await ImageCompress.contain(filePath: resourceFile.path, compressFormat: CompressFormat.webP, maxWidth: 1024 * 3, maxHeight: 1024 * 3);

      File file = File('${data.outputDir}/${resourceFile.fileName}');
      await file.writeAsBytes(bytes);
      compressInfo.status = CompressStatus.success;
      _update(compressInfo);
      sendPort.send(compressInfo);
      tasks.removeWhere((v) => v.data.id == compressInfo.data.id);
    } catch (e) {
      compressInfo.status = CompressStatus.fail;
      _update(compressInfo);
      sendPort.send(compressInfo);
    }
  }

  /// 视频压缩
  static void _compressVideo(ResourceFile resourceFile, CompressParams data, CompressInfo compressInfo, SendPort sendPort) async {
    try {
      compressInfo.status = CompressStatus.compressing;
      _update(compressInfo);
      sendPort.send(compressInfo);
      MediaInfo? mediaInfo = await VideoCompress.compressVideo(resourceFile.path, quality: VideoQuality.DefaultQuality, deleteOrigin: false);
      if (mediaInfo != null) {
        compressInfo.mediaInfo = mediaInfo;
        compressInfo.status = CompressStatus.success;
        _update(compressInfo);
        sendPort.send(compressInfo);
      } else {
        compressInfo.status = CompressStatus.fail;
        _update(compressInfo);
        sendPort.send(compressInfo);
      }
    } catch (e) {
      compressInfo.status = CompressStatus.fail;
      _update(compressInfo);
      sendPort.send(compressInfo);
    }
  }
}

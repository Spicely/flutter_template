import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

part 'enums/system_action.dart';
part 'enums/system_file_entity_type.dart';
part 'listener/system_manager_listener.dart';
part 'models/system_action_model.dart';
part 'models/system_file_entity.dart';
part 'models/system_method_model.dart';
part 'system_method.dart';
part 'enums/system_file_type.dart';

class _IsolateTaskData {
  final SendPort sendPort;

  final RootIsolateToken? rootIsolateToken;

  _IsolateTaskData(this.sendPort, this.rootIsolateToken);
}

class SystemManager {
  static late Isolate isolate;

  /// 线程通知
  static late SendPort _sendPort;

  static final ObserverList<SystemManagerListener> _listeners = ObserverList<SystemManagerListener>();

  static List<SystemManagerListener> get listeners {
    final List<SystemManagerListener> localListeners = List<SystemManagerListener>.from(_listeners);
    return localListeners;
  }

  static bool get hasListeners {
    return _listeners.isNotEmpty;
  }

  static void addListener(SystemManagerListener listener) {
    _listeners.add(listener);
  }

  static void removeListener(SystemManagerListener listener) {
    _listeners.remove(listener);
  }

  /// 事件触发
  static void _onEvent(Function(SystemManagerListener) callback) {
    for (SystemManagerListener listener in listeners) {
      if (!_listeners.contains(listener)) {
        return;
      }
      callback(listener);
    }
  }

  static Future<void> init() async {
    ReceivePort port = ReceivePort();
    RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;

    isolate = await Isolate.spawn(
      _isolateEntry,
      _IsolateTaskData(port.sendPort, rootIsolateToken),
    );

    Completer completer = Completer();
    port.listen((msg) {
      try {
        if (msg is _SystemMethodModel) {
          switch (msg.action) {
            case _SystemAction.readerDirectory:
              _onEvent((listener) => listener.onFileReader(msg.data as SystemFileEntity));
              break;
          }
        }
        if (msg is SendPort) {
          _sendPort = msg;
          completer.complete();
          return;
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    return await completer.future;
  }

  static Future<void> _isolateEntry(_IsolateTaskData task) async {
    if (task.rootIsolateToken != null) {
      BackgroundIsolateBinaryMessenger.ensureInitialized(task.rootIsolateToken!);
    }
    final ReceivePort receivePort = ReceivePort();

    receivePort.listen((msg) async {
      try {
        if (msg is _SystemActionModel) {
          switch (msg.action) {
            case _SystemAction.readerDirectory:
              _SystemMethod.directoryList(msg.path, task.sendPort);
              break;
          }
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    task.sendPort.send(receivePort.sendPort);
  }

  /// 获取目录
  static void readerDirectory(String path) {
    _sendPort.send(_SystemActionModel(path, _SystemAction.readerDirectory));
  }
}

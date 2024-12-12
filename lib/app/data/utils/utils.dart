import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:logger/logger.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../env/env.dart';
import '../../components/dialog/upgrade_dialog/upgrade_dialog.dart';
import '../models/upgrade_model.dart';
import '../manager/compress_manager/compress_manager.dart';
import '../manager/isar_manager/isar_manager.dart';
import '../manager/system_manager/system_manager.dart';
import '../mixins/permission_mixin.dart';

part '_apis.dart';
part '_config.dart';
part '_error.dart';
part '_http.dart';
part '_plugins.dart';
part '_tools.dart';
part '_upgrade.dart';

class _Utils extends _Upgrade {
  _Utils._();

  final Logger logger = Logger(printer: PrettyPrinter(methodCount: 2, errorMethodCount: 8, lineLength: 120, colors: true, printEmojis: true));

  late _Apis apis = _Apis._(_http);

  _Config config = _Config._();

  late _Error error = _Error._(logger);

  final _Http _http = _Http._(debug: kDebugMode);

  _Plugins plugins = _Plugins._();

  _Tools tools = _Tools._();

  Future<void> init() async {
    await config.init();
    await plugins.init();

    _http.baseUrl = kReleaseMode ? Env.baseUrl : Env.baseUrlDev;

    _http.interceptors = (Dio? d) {
      return [
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            options.headers = {
              ...options.headers,

              /// 增加固定参数
              'channel': 'ACJL001',
            };
            handler.next(options);
          },
          onResponse: (Response<dynamic> response, ResponseInterceptorHandler handler) {
            switch (response.data['code']) {
              case 100:
                response.data = response.data['data'];
                handler.next(response);
                break;
              default:
                handler.reject(DioException(requestOptions: response.requestOptions, error: response.data['code'], message: response.data['message']));
            }
          },
        ),
      ];
    };
  }

  /// 异常捕获
  Future<void> exceptionCapture(Function() cb, {void Function(DioException)? dioError, void Function(Object)? error}) async {
    try {
      await cb();
    } on DioException catch (e) {
      dioError != null ? dioError.call(e) : this.error.dioError(e);
    } catch (e) {
      error != null ? error.call(e) : this.error.error(e);
    }
  }
}

final utils = _Utils._();

part of 'utils.dart';

/////////////////////////////////////////////////////////////////////////
///
/// All rights reserved.
///
/// author: Spicely
///
/// Summary: 配置文件
///
/// Date: 2024年11月28日 22:23:07 Thursday
///
//////////////////////////////////////////////////////////////////////////

class _Config {
  _Config._();

  bool _isInit = false;

  late final Directory directory;

  /// 压缩输出路径
  late String compressedOutputPath;

  /// 应用名称
  String appName = 'Template';

  Future<void> init() async {
    if (_isInit) return;
    _isInit = true;
    directory = await getApplicationSupportDirectory();
    compressedOutputPath = p.join(directory.path, 'compress');
    await Directory(compressedOutputPath).create(recursive: true);
    await IsarManager.init(directory.path);
    await CompressManager.init(CompressParams(outputDir: compressedOutputPath));
    await SystemManager.init();
    debugPrint(directory.path);

    utils._http.baseUrl = kReleaseMode ? Env.baseUrl : Env.baseUrlDev;

    utils._http.interceptors = (Dio? d) {
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
}

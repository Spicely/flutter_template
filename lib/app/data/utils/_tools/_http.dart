// ignore_for_file: unused_element, non_constant_identifier_names

part of '../utils.dart';

/////////////////////////////////////////////////////////////////////////
///
/// All rights reserved.
///
/// author: Spicely
///
/// Summary: 网络请求工具类
///
/// Date: 2024年12月13日 09:34:17 Friday
///
//////////////////////////////////////////////////////////////////////////

typedef HttpInterceptors = List<Interceptor> Function(Dio? dio);

enum HttpMethod {
  get,

  post,

  put,

  patch,

  delete,
}

class _Http {
  final bool debug;

  /// 超时时间
  final Duration connectTimeout;

  final Duration receiveTimeout;

  _Http._({
    this.debug = false,
    this.connectTimeout = const Duration(seconds: 10),
    this.receiveTimeout = const Duration(seconds: 10),
  });

  /// global dio object
  Dio? _dio;

  /// 请求地址
  set baseUrl(String v) => _dio == null ? _options.baseUrl = v : _dio?.options.baseUrl = v;

  String get baseUrl => _dio == null ? _options.baseUrl : _dio!.options.baseUrl;

  /// 代理设置 代理地址
  String? proxyUrl;

  /// 添加额外功能
  HttpInterceptors? interceptors;

  late final BaseOptions _options = BaseOptions(
    connectTimeout: connectTimeout,
    receiveTimeout: receiveTimeout,
  );

  /// request method
  Future<T> request<T>(
    String url, {
    dynamic data,
    HttpMethod method = HttpMethod.post,
    Map<String, dynamic>? headers,
    String? contentType,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    T Function(dynamic)? convert,
  }) async {
    data = data ?? (method == HttpMethod.get ? null : {});
    headers = headers ?? {};
    contentType = contentType ?? Headers.jsonContentType;

    Dio? dio = await createInstance();
    T result;

    Response<dynamic> response = await dio!.request(
      url,
      queryParameters: method == HttpMethod.get ? data : null,
      data: method != HttpMethod.get ? data : null,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
      options: Options(
        method: _getMethod(method),
        headers: headers,
        contentType: contentType,
      ),
    );

    if (convert != null) {
      result = await compute((data) => convert(data), response.data);
    } else {
      result = response.data;
    }

    return result;
  }

  String _getMethod(HttpMethod method) {
    switch (method.index) {
      case 1:
        return 'POST';
      case 2:
        return 'PUT';
      case 3:
        return 'PATCH';
      case 4:
        return 'DELETE';
      default:
        return 'GET';
    }
  }

  /// 创建 dio 实例对象
  Future<Dio?> createInstance() async {
    if (_dio == null) {
      _dio = Dio(_options);

      interceptors?.call(_dio).forEach((i) {
        _dio!.interceptors.add(i);
      });

      /// 设置代理
      if (proxyUrl != null) {
        _dio!.httpClientAdapter = IOHttpClientAdapter(
          createHttpClient: () {
            HttpClient client = HttpClient()..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
            client.findProxy = (uri) {
              return "PROXY $proxyUrl";
            };
            return client;
          },
        );
      }

      if (debug) {
        _dio!.interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90,
            filter: (options, args) => !args.isResponse || !args.hasUint8ListData,
          ),
        );
      }
    }

    return _dio;
  }
}

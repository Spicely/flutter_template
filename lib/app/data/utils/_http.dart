// ignore_for_file: unused_element

part of 'utils.dart';

typedef HttpInterceptors = List<Interceptor> Function(Dio? dio);

enum HttpMethod {
  get,

  post,

  put,

  patch,

  delete,
}

class _Http {
  /// global dio object
  static Dio? _dio;

  /// 请求地址
  static set baseUrl(String v) => _dio == null ? _options.baseUrl = v : _dio?.options.baseUrl = v;

  static String get baseUrl => _dio == null ? _options.baseUrl : _dio!.options.baseUrl;

  /// 超时时间
  static Duration connectTimeout = const Duration(seconds: 10);

  static Duration receiveTimeout = const Duration(seconds: 10);

  /// 输出请求内容
  static bool debug = false;

  /// 代理设置 代理地址
  // static String? PROXY_URL;

  /// 添加额外功能
  static HttpInterceptors? interceptors;

  static final BaseOptions _options = BaseOptions(
    connectTimeout: connectTimeout,
    receiveTimeout: receiveTimeout,
  );

  /// request method
  static Future<T> request<T>(
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
      result = convert(response.data);
    } else {
      result = response.data;
    }

    return result;
  }

  static String _getMethod(HttpMethod method) {
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
  static Future<Dio?> createInstance() async {
    if (_dio == null) {
      _dio = Dio(_options);

      interceptors?.call(_dio).forEach((i) {
        _dio!.interceptors.add(i);
      });

      // if (kIsWeb) {
      //   // var adapter = BrowserHttpClientAdapter();
      //   // adapter.withCredentials = withCredentials!;
      //   // _dio!.httpClientAdapter = adapter;
      // } else {
      //   var appDocDir = await getApplicationDocumentsDirectory();
      //   String appDocPath = appDocDir.path;
      //   PersistCookieJar cookieJar = PersistCookieJar(storage: FileStorage('$appDocPath/.cookies/'));
      //   _dio!.interceptors.add(CookieManager(cookieJar));
      // }

      // /// 设置代理
      // if (PROXY_URL != null) {
      //   _dio!.httpClientAdapter = IOHttpClientAdapter(
      //     createHttpClient: () {
      //       HttpClient client = HttpClient()..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      //       client.findProxy = (uri) {
      //         return "PROXY $PROXY_URL";
      //       };
      //       return client;
      //     },
      //   );
      // }

      /// 忽略证书
      // if (ignoreCertificate) {
      //   _dio!.httpClientAdapter = IOHttpClientAdapter(
      //     createHttpClient: () {
      //       HttpClient client = new HttpClient()..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      //       return client;
      //     },
      //   );
      // }
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

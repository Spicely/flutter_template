part of 'utils.dart';

/////////////////////////////////////////////////////////////////////////
///
/// All rights reserved.
///
/// author: Spicely
///
/// Summary: 请求接口
///
/// Date: 2024年12月09日 22:43:42 Monday
///
//////////////////////////////////////////////////////////////////////////

class _Apis {
  final _Http _http;

  _Apis._(this._http);

  /// 登录
  Future<dynamic> login(dynamic data) => _http.request('/login', data: data);
}

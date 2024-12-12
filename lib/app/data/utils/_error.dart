part of 'utils.dart';

/////////////////////////////////////////////////////////////////////////
///
/// All rights reserved.
///
/// author: Spicely
///
/// Summary: 错误类
///
/// Date: 2024年12月09日 13:38:43 Monday
///
//////////////////////////////////////////////////////////////////////////

class _Error {
  final Logger logger;

  _Error._(this.logger);

  void dioError(DioException dioError) {
    logger.e(dioError);
  }

  void error(Object error) {
    logger.e(error);
  }
}

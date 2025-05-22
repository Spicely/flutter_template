import 'dart:async';

import 'package:tobias/tobias.dart';

/////////////////////////////////////////////////////////////////////////
///
/// All rights reserved.
///
/// author: Spicely
///
/// Summary: 支付宝支付
///
/// Date: 2025年05月22日 13:50:30 Thursday
///
//////////////////////////////////////////////////////////////////////////

class AlipayManager {
  static Future<void> purchase(String order) async {
    Completer completer = Completer();
    Tobias tobias = Tobias();

    tobias.pay(order).then((res) {
      if (res['resultStatus'] == '9000') {
        completer.complete();
      } else if (res['resultStatus'] == '4000') {
        completer.completeError(res['memo']);
      } else {
        completer.completeError('支付失败');
      }
    });

    await completer.future;
  }
}

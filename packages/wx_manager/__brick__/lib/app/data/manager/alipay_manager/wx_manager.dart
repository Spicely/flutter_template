import 'dart:async';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:fluwx/fluwx.dart';

part './generate_sign_vo.dart';
/////////////////////////////////////////////////////////////////////////
///
/// All rights reserved.
///
/// author: Spicely
///
/// Summary: 微信支付
///
/// Date: 2025年05月22日 13:50:48 Thursday
///
//////////////////////////////////////////////////////////////////////////

class WxManager {
  static Fluwx? _iap;

  static final StreamController<WeChatResponse> _purchaseStreamController = StreamController<WeChatResponse>.broadcast();

  static Stream<WeChatResponse> get purchaseStream => _purchaseStreamController.stream;

  static void _init() async {
    _iap = Fluwx();
    _iap?.registerApi(appId: '');
    _iap?.addSubscriber((weChatResponse) {
      _purchaseStreamController.add(weChatResponse);
    });

    debugPrint("InAppPurchaseManager initialized.");
  }

  static Future<void> purchase(GenerateSignVo sign) async {
    if (_iap == null) {
      _init();
    }
    final completer = Completer();

    StreamSubscription? subscription;
    subscription = purchaseStream.listen((weChatResponse) {
      if (weChatResponse.errCode == 0) {
        completer.complete();
      } else {
        completer.completeError('支付失败');
      }
      subscription?.cancel();
    });

    _iap?.pay(
      which: Payment(
        appId: sign.appId ?? '',
        partnerId: sign.partnerId ?? '',
        prepayId: sign.prepayId ?? '',
        packageValue: sign.packageValue ?? '',
        nonceStr: sign.nonceStr ?? '',
        timestamp: int.parse(sign.timeStamp ?? ''),
        sign: sign.sing ?? '',
      ),
    );
    return completer.future;
  }

  static void dispose() {
    _purchaseStreamController.close();
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseManager {
  static InAppPurchase? _iap;

  static final StreamController<PurchaseDetails> _purchaseStreamController = StreamController<PurchaseDetails>.broadcast();

  static Stream<PurchaseDetails> get purchaseStream => _purchaseStreamController.stream;

  static void _init() async {
    _iap = InAppPurchase.instance;
    _iap?.purchaseStream.listen((purchaseDetailsList) {
      for (final purchaseDetails in purchaseDetailsList) {
        _purchaseStreamController.add(purchaseDetails);
        // 自动完成挂起的成功订单
        if (purchaseDetails.status == PurchaseStatus.purchased) {
          _iap?.completePurchase(purchaseDetails);
        }
      }
    });

    debugPrint("InAppPurchaseManager initialized.");
  }

  static Future<PurchaseDetails> purchase(String productId) async {
    if (_iap == null) {
      _init();
    }
    final productDetails = await _getProductDetails(productId);
    if (productDetails == null) {
      throw Exception("Product details not found for: \$productId");
    }

    final purchaseParam = PurchaseParam(productDetails: productDetails);
    final completer = Completer<PurchaseDetails>();

    StreamSubscription? subscription;
    subscription = purchaseStream.listen((purchaseDetails) {
      if (purchaseDetails.productID == productId) {
        if (purchaseDetails.status == PurchaseStatus.purchased) {
          _iap?.completePurchase(purchaseDetails);
          completer.complete(purchaseDetails);
          subscription?.cancel();
        } else if (purchaseDetails.status == PurchaseStatus.error) {
          _iap?.completePurchase(purchaseDetails);
          completer.completeError(purchaseDetails.error?.message ?? "支付失败");
          subscription?.cancel();
        }
      }
      if (purchaseDetails.status == PurchaseStatus.canceled) {
        _iap?.completePurchase(purchaseDetails);
        completer.completeError('取消支付');
        subscription?.cancel();
      }
    });

    _iap?.buyConsumable(purchaseParam: purchaseParam);
    return completer.future;
  }

  static Future<ProductDetails?> _getProductDetails(String productId) async {
    final response = await _iap!.queryProductDetails({productId});
    if (response.error != null) {
      throw Exception("Error querying product details: \${response.error}");
    }
    if (response.productDetails.isEmpty) {
      throw Exception("No product details found for: \$productId");
    }
    return response.productDetails.first;
  }

  static Future<void> restorePurchases() async {
    await _iap?.restorePurchases();
  }

  static void dispose() {
    _purchaseStreamController.close();
  }
}

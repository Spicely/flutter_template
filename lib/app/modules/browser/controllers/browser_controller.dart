import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class BrowserController extends GetxController {
  void onWebViewCreated(InAppWebViewController controller) {
    controller.loadUrl(urlRequest: URLRequest(url: WebUri(Get.parameters['url'] ?? '')));
  }
}

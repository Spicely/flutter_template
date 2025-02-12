import 'dart:ui';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class BrowserController extends GetxController {
  String title = Get.parameters['title'] ?? '';

  String url = Get.parameters['url'] ?? '';

  RxDouble progressValue = 0.0.obs;

  double xx = 0.3;

  final WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000));

  @override
  void onInit() {
    controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // loadProgress(progress);
          loadProgress(progress);
        },
        onPageStarted: (String url) {
          // Log.i("=======112333");
        },
        onPageFinished: (String url) {
          // Log.i("=======1123334444");
        },
        onWebResourceError: (WebResourceError error) {},
      ),
    );
    super.onInit();
    if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      final AndroidWebViewController androidController = controller.platform as AndroidWebViewController;
      //textZoom 默认值是 100
      if (title == '用户协议' || title == '服务协议' || title == '会员协议' || title == '隐私政策') {
        androidController.setTextZoom(250);
      }
    }

    loadHtmlAction();
  }

  void loadProgress(int value) {
    progressValue.value = value / 100.0;
  }

  void loadHtmlAction() {
    controller.loadRequest(Uri.parse(url));
  }
}

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserController extends GetxController {
  String title = Get.parameters['title'] ?? '';

  String url = Get.parameters['url'] ?? '';

  final WebViewController webViewController = WebViewController();

  @override
  void onInit() {
    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
      ),
    );
    super.onInit();
    webViewController.loadRequest(Uri.parse(url));
  }
}

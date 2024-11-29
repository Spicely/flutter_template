import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../controllers/browser_controller.dart';

class BrowserView extends GetView<BrowserController> {
  const BrowserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.parameters['title'] ?? ''),
        centerTitle: true,
      ),
      body: InAppWebView(
        onWebViewCreated: controller.onWebViewCreated,
      ),
    );
  }
}

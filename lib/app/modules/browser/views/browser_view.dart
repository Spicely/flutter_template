import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../controllers/browser_controller.dart';

/////////////////////////////////////////////////////////////////////////
///
/// All rights reserved.
///
/// author: Spicely
///
/// Summary: webview
///
/// Date: 2024年11月30日 02:04:40 Saturday
///
//////////////////////////////////////////////////////////////////////////

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

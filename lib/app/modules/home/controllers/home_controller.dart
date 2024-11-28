import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    FlutterNativeSplash.remove();
  }
}

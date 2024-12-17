import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/cached_image/cached_image.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          Center(
            child: CachedImage(
              height: 100,
              width: 100,
              circular: 10,
              fit: BoxFit.cover,
              imageUrl: 'https://pics6.baidu.com/feed/8ad4b31c8701a18b47b283e906a51f072938fe51.jpeg@f_auto?token=80d5edb0168c8df3ce9a10ace741f843',
            ),
          ),
        ],
      ),
    );
  }
}

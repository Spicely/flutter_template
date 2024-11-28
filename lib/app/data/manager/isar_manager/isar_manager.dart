import 'dart:async';

import 'package:isar/isar.dart';

import 'models/config_model/config_model.dart';

part 'isar_config_manager.dart';

class IsarManager {
  static late Isar isar;

  static late IsarConfigManager configManager;

  static Future<void> init(String directory) async {
    isar = await Isar.open(
      [ConfigModelSchema],
      directory: directory,
    );

    configManager = IsarConfigManager(isar);
  }

  static Future<void> close() async {
    await isar.close();
  }

  static Future<void> clear() async {
    await isar.clear();
  }
}

part of 'isar_manager.dart';

class IsarConfigManager {
  final Isar isar;

  late final IsarCollection<ConfigModel> collection;

  IsarConfigManager(this.isar) {
    collection = isar.configModels;
  }

  /// 获取配置信息
  Future<ConfigModel> get() async {
    ConfigModel? config = await collection.where().findFirst();
    return config ?? ConfigModel();
  }

  /// 保存配置信息
  Future<void> save(ConfigModel config) async {
    Completer completer = Completer();
    await isar.writeTxn(() async {
      await collection.put(config);
      completer.complete(config);
    });
    return completer.future;
  }
}

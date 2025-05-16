part of 'isar_manager.dart';

class IsarConfigManager {
  final Isar isar;

  late final IsarCollection<ConfigModel> collection;

  IsarConfigManager(this.isar) {
    collection = isar.configModels;
  }

  /// 获取配置信息
  Future<ConfigModel> get() async {
    List<ConfigModel> configs = await collection.where().findAll();
    if (configs.isEmpty) {
      ConfigModel config = ConfigModel();
      config = await save(config);
      return config;
    } else {
      return configs.first;
    }
  }

  /// 保存配置信息
  Future<ConfigModel> save(ConfigModel config) async {
    Completer<ConfigModel> completer = Completer<ConfigModel>();
    await isar.writeTxn(() async {
      int id = await collection.put(config);
      config.id ??= id;
      completer.complete(config);
    });
    return completer.future;
  }
}

import 'package:isar/isar.dart';

part 'config_model.g.dart';

@collection
class ConfigModel {
  Id? id;

  /// 是否同意协议
  @Index(type: IndexType.value)
  bool isAgreement;

  ConfigModel({
    this.id,
    this.isAgreement = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'isAgreement': isAgreement,
    };
  }
}

import 'package:isar/isar.dart';

part 'config_model.g.dart';

@collection
class ConfigModel {
  final Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  bool isAgreement;

  ConfigModel({
    this.isAgreement = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'isAgreement': isAgreement,
    };
  }
}

import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('初始化模板...');

  try {
    context.logger.info('================  开始初始化模板  ======================');
    final pubspecPath = './pubspec.yaml';
    final pubspecFile = File(pubspecPath);
    final content = await pubspecFile.readAsString();
    final editor = YamlEditor(content);

    final yamlMap = loadYaml(content);

    // 若 dependencies 不存在则添加
    if (!yamlMap.containsKey('dependencies')) {
      editor.update(['dependencies'], {});
    }

    // 添加 in_app_purchase 依赖
    editor.update(['dependencies', 'in_app_purchase']);

    await pubspecFile.writeAsString(editor.toString());

    progress.complete();
    context.logger.success('================  初始化模板成功  ======================');
  } catch (e) {
    progress.fail('================  模板初始化失败  ======================/n $e');
    exit(1);
  }
}

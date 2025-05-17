import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('初始化模板...');
  final orgName = context.vars['org_name'];

  String projectName = context.vars['project_name'];

  try {
    context.logger.info('================  开始初始化模板  ======================');
    final result = await Process.run('cd', ['./${projectName.toLowerCase()}', '&&', 'flutter', 'create', '.', '--org', orgName], runInShell: true);

    if (result.exitCode != 0) {
      context.logger.err(result.stderr);
      progress.fail('================  模板初始化失败  ======================');
      exit(result.exitCode);
    }

    context.logger.info(result.stdout);
    progress.complete();
    context.logger.success('================  初始化模板成功  ======================');
  } catch (e) {
    progress.fail('================  模板初始化失败  ======================/n $e');
    exit(1);
  }
}

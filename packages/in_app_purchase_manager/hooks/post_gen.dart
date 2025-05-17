import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('添加依赖...');

  try {
    context.logger.info('================  开始添加依赖  ======================');
    final result = await Process.run('flutter', ['pub', 'add', 'in_app_purchase'], runInShell: true);

    if (result.exitCode != 0) {
      context.logger.err(result.stderr);
      progress.fail('================  依赖添加失败  ======================');
      exit(result.exitCode);
    }

    context.logger.info(result.stdout);
    progress.complete();
    context.logger.success('================  依赖添加完成  ======================');
  } catch (e) {
    progress.fail('================  依赖添加失败  ====================== /n $e');
    exit(1);
  }
}

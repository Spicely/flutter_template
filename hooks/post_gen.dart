import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Initializing template...');
  final orgName = context.vars['org_name'];

  final projectName = context.vars['project_name'];

  try {
    context.logger.info('================  开始初始化模板  ======================');
    final result = await Process.run('cd', ['./${projectName}', '&&', 'flutter', 'create', '.', '--org', orgName], runInShell: true);

    if (result.exitCode != 0) {
      context.logger.err(result.stderr);
      progress.fail('Failed to create Flutter project');
      exit(result.exitCode);
    }

    context.logger.info(result.stdout);
    progress.complete();
    context.logger.success('Template initialized successfully!');
  } catch (e) {
    progress.fail('Error initializing template: $e');
    exit(1);
  }
}

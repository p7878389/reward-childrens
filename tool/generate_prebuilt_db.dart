// ignore_for_file: avoid_print
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

/// 生成预编译数据库
/// 运行: dart run tool/generate_prebuilt_db.dart
void main() async {
  final projectRoot = Directory.current.path;
  final outputPath = p.join(projectRoot, 'assets', 'database', 'prebuilt.db');
  final outputDir = Directory(p.dirname(outputPath));

  // 确保目录存在
  if (!await outputDir.exists()) {
    await outputDir.create(recursive: true);
  }

  // 删除旧文件
  final outputFile = File(outputPath);
  if (await outputFile.exists()) {
    await outputFile.delete();
  }

  print('生成预编译数据库: $outputPath');

  // 创建数据库
  final db = NativeDatabase(outputFile);

  // 读取并执行建表 SQL（从 drift 生成的 schema）
  // 这里需要手动创建表结构，因为无法直接使用 AppDatabase

  // 读取成语数据
  final idiomSqlPath = p.join(projectRoot, 'assets', 'idiom_game', 'data', 'idioms.sql');
  final idiomSqlFile = File(idiomSqlPath);

  if (!await idiomSqlFile.exists()) {
    print('错误: 找不到 idioms.sql');
    exit(1);
  }

  print('读取成语数据...');
  final sqlContent = await idiomSqlFile.readAsString();
  final statements = sqlContent.split(';\n')
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty && !s.startsWith('--'))
      .toList();

  print('共 ${statements.length} 条 SQL 语句');
  print('');
  print('⚠️  注意: 此脚本需要配合 Flutter 环境运行');
  print('请使用以下命令生成预编译数据库:');
  print('');
  print('  flutter run -d macos -t tool/generate_prebuilt_db_flutter.dart');
  print('');

  await db.close();
  await outputFile.delete();

  print('或者手动执行以下步骤:');
  print('1. 运行应用，等待数据库初始化完成');
  print('2. 从设备中导出数据库文件');
  print('3. 将数据库文件复制到 assets/database/prebuilt.db');
}

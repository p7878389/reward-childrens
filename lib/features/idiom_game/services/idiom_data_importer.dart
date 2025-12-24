import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:children_rewards/core/database/app_database.dart';
import 'package:characters/characters.dart';
import 'package:children_rewards/core/logging/app_logger.dart';

/// 成语数据导入器 - 从 assets 导入成语数据到数据库
class IdiomDataImporter {
  static const String _tag = 'IdiomDataImporter';
  final AppDatabase _db;

  IdiomDataImporter(this._db);

  /// 检查并导入成语数据（如果数据库为空）
  Future<bool> importIfNeeded() async {
    final countQuery = _db.selectOnly(_db.idioms)..addColumns([_db.idioms.id.count()]);
    final result = await countQuery.getSingle();
    final count = result.read(_db.idioms.id.count()) ?? 0;

    logger.info(_tag, 'importIfNeeded: 当前成语数量=$count');

    if (count > 0) return true;

    return await importFromAssets();
  }

  /// 强制重新导入成语数据（先清空再导入）
  Future<bool> forceReimport() async {
    logger.info(_tag, 'forceReimport: 开始强制重新导入...');

    try {
      // 清空现有数据
      await _db.delete(_db.idioms).go();
      logger.info(_tag, 'forceReimport: 已清空旧数据');

      // 重新导入
      final success = await importFromAssets();
      logger.info(_tag, 'forceReimport: 导入${success ? "成功" : "失败"}');

      return success;
    } catch (e) {
      logger.error(_tag, 'forceReimport: 异常 $e');
      return false;
    }
  }

  /// 获取当前成语数量
  Future<int> getIdiomCount() async {
    final countQuery = _db.selectOnly(_db.idioms)..addColumns([_db.idioms.id.count()]);
    final result = await countQuery.getSingle();
    return result.read(_db.idioms.id.count()) ?? 0;
  }

  /// 从 assets 导入成语数据
  Future<bool> importFromAssets() async {
    try {
      logger.info(_tag, 'importFromAssets: 开始导入...');

      final jsonStr = await rootBundle.loadString('assets/idiom_game/data/idiom_processed.json');
      final List<dynamic> data = jsonDecode(jsonStr);

      if (data.isEmpty) {
        logger.warning(_tag, 'importFromAssets: JSON数据为空');
        return false;
      }

      logger.info(_tag, 'importFromAssets: 准备导入 ${data.length} 条成语');

      const batchSize = 500;
      for (var i = 0; i < data.length; i += batchSize) {
        final end = (i + batchSize < data.length) ? i + batchSize : data.length;
        final batchData = data.sublist(i, end);

        await _db.batch((batch) {
          batch.insertAll(
            _db.idioms,
            batchData.map((item) {
              final word = item['word'] as String;
              final pinyin = item['pinyin'] as String? ?? '';

              // 解析带声调的首字拼音和尾字拼音
              final pinyinParts = pinyin.split(' ');
              final firstPinyin = pinyinParts.isNotEmpty ? pinyinParts.first : '';
              final lastPinyin = pinyinParts.isNotEmpty ? pinyinParts.last : '';

              return IdiomsCompanion.insert(
                word: word,
                pinyin: pinyin,
                firstPinyinNoTone: item['firstPinyinNoTone'] ?? '',
                lastPinyinNoTone: item['lastPinyinNoTone'] ?? '',
                firstPinyin: Value(firstPinyin),
                lastPinyin: Value(lastPinyin),
                firstChar: item['firstChar'] ?? word.characters.first,
                lastChar: item['lastChar'] ?? word.characters.last,
                explanation: Value(item['explanation']),
                source: Value(item['source']),
                example: Value(item['example']),
                gradeLevel: Value(item['gradeLevel'] ?? 1),
                frequency: Value(item['frequency'] ?? 50),
                createdAt: DateTime.now(),
              );
            }),
            mode: InsertMode.insertOrIgnore,
          );
        });
      }

      logger.info(_tag, 'importFromAssets: 导入完成');
      return true;
    } catch (e) {
      logger.error(_tag, 'importFromAssets: 异常 $e');
      return false;
    }
  }
}

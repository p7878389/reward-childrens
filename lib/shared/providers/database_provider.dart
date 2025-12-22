import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/database/app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  // 保持单例
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

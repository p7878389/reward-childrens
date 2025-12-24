import 'package:drift/drift.dart';
import 'package:children_rewards/core/database/app_database.dart';

/// 成语游戏配置数据访问对象
class IdiomGameSettingsDao {
  final AppDatabase _db;

  IdiomGameSettingsDao(this._db);

  /// 获取孩子的游戏配置
  Future<IdiomGameSetting?> getSettings(int childId) async {
    return (_db.select(_db.idiomGameSettings)
          ..where((t) => t.childId.equals(childId))
          ..where((t) => t.isDeleted.equals(false)))
        .getSingleOrNull();
  }

  /// 创建或更新游戏配置
  Future<int> upsertSettings({
    required int childId,
    int? currentGrade,
    int? customCountdown,
    int? customFreeHints,
    int? matchMode,
    bool? soundEnabled,
    bool? includeRareIdioms,
  }) async {
    final existing = await getSettings(childId);
    final now = DateTime.now();

    if (existing != null) {
      // 更新
      await (_db.update(_db.idiomGameSettings)
            ..where((t) => t.id.equals(existing.id)))
          .write(IdiomGameSettingsCompanion(
        currentGrade: currentGrade != null ? Value(currentGrade) : const Value.absent(),
        customCountdown: Value(customCountdown),
        customFreeHints: Value(customFreeHints),
        matchMode: matchMode != null ? Value(matchMode) : const Value.absent(),
        soundEnabled: soundEnabled != null ? Value(soundEnabled) : const Value.absent(),
        includeRareIdioms: includeRareIdioms != null ? Value(includeRareIdioms) : const Value.absent(),
        updatedAt: Value(now),
      ));
      return existing.id;
    } else {
      // 创建
      return _db.into(_db.idiomGameSettings).insert(
            IdiomGameSettingsCompanion.insert(
              childId: childId,
              currentGrade: Value(currentGrade ?? 1),
              customCountdown: Value(customCountdown),
              customFreeHints: Value(customFreeHints),
              matchMode: Value(matchMode ?? 0),
              soundEnabled: Value(soundEnabled ?? true),
              includeRareIdioms: Value(includeRareIdioms ?? false),
              createdAt: now,
            ),
          );
    }
  }

  /// 更新当前年级
  Future<void> updateCurrentGrade(int childId, int grade) async {
    final existing = await getSettings(childId);
    if (existing != null) {
      await (_db.update(_db.idiomGameSettings)
            ..where((t) => t.id.equals(existing.id)))
          .write(IdiomGameSettingsCompanion(
        currentGrade: Value(grade),
        updatedAt: Value(DateTime.now()),
      ));
    } else {
      await upsertSettings(childId: childId, currentGrade: grade);
    }
  }

  /// 重置为默认配置
  Future<void> resetToDefault(int childId) async {
    final existing = await getSettings(childId);
    if (existing != null) {
      await (_db.update(_db.idiomGameSettings)
            ..where((t) => t.id.equals(existing.id)))
          .write(IdiomGameSettingsCompanion(
        currentGrade: const Value(1),
        customCountdown: const Value(null),
        customFreeHints: const Value(null),
        matchMode: const Value(0),
        soundEnabled: const Value(true),
        updatedAt: Value(DateTime.now()),
      ));
    }
  }

  /// 删除配置
  Future<void> deleteSettings(int childId) async {
    await (_db.update(_db.idiomGameSettings)
          ..where((t) => t.childId.equals(childId)))
        .write(const IdiomGameSettingsCompanion(
      isDeleted: Value(true),
    ));
  }

  /// 更新配置
  Future<void> updateSettings(IdiomGameSettingsCompanion companion) async {
    await (_db.update(_db.idiomGameSettings)
          ..where((t) => t.id.equals(companion.id.value)))
        .write(companion);
  }
}

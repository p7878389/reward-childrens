import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/shared/providers/database_provider.dart';
import 'package:children_rewards/features/children/domain/repositories/i_children_repository.dart';

/// 宝贝数据仓库实现
class ChildrenRepository implements IChildrenRepository {
  final AppDatabase _db;

  ChildrenRepository(this._db);

  @override
  Stream<List<ChildrenData>> watchAllChildren() {
    return (_db.select(_db.children)
          ..where((t) => t.isDeleted.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc)]))
        .watch();
  }

  @override
  Future<ChildrenData?> getChild(int id) {
    return (_db.select(_db.children)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  @override
  Stream<ChildrenData?> watchChild(int id) {
    return (_db.select(_db.children)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  @override
  Future<int> createChild({
    required String name,
    required String gender,
    String? avatar,
    String? birthday,
  }) {
    return _db.into(_db.children).insert(ChildrenCompanion.insert(
          name: name,
          gender: gender,
          avatar: Value(avatar),
          birthday: Value(birthday),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
  }

  @override
  Future<bool> updateChild(ChildrenData child) {
    return _db.update(_db.children).replace(child);
  }

  @override
  Future<int> deleteChild(int id) {
    // 软删除
    return (_db.update(_db.children)..where((t) => t.id.equals(id))).write(
      ChildrenCompanion(
        isDeleted: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

final childrenRepositoryProvider = Provider<ChildrenRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ChildrenRepository(db);
});
# Children Rewards - 数据库架构设计

**版本**: 1.0.0
**技术栈**: Flutter + SQLite (drift)
**最后更新**: 2025-12-19

---

## 1. 概述

本文档定义了 Children Rewards App 的数据库架构设计，基于 SQLite 数据库，使用 drift 作为 Flutter 端的 ORM 框架。

### 1.1 设计原则

- **数据完整性**: 使用外键约束保证关联数据一致性
- **软删除**: 宝贝档案支持软删除，保留历史记录
- **审计追踪**: 关键表包含 created_at/updated_at 时间戳
- **查询优化**: 针对高频查询场景建立索引

---

## 2. ER 关系图

```
┌─────────────┐       ┌─────────────┐       ┌─────────────┐
│   children  │       │    rules    │       │   rewards   │
├─────────────┤       ├─────────────┤       ├─────────────┤
│ id (PK)     │       │ id (PK)     │       │ id (PK)     │
│ name        │       │ child_id(FK)│───┐   │ name        │
│ avatar      │       │ name        │   │   │ price       │
│ gender      │       │ icon        │   │   │ category    │
│ birthday    │       │ points      │   │   │ stock       │
│ stars       │       │ type        │   │   │ is_active   │
│ is_deleted  │       │ is_active   │   │   └──────┬──────┘
└──────┬──────┘       └─────────────┘   │          │
       │                                │          │
       │ 1:N                            │          │
       ▼                                │          │
┌─────────────┐                         │          │
│point_records│                         │          │
├─────────────┤                         │          │
│ id (PK)     │                         │          │
│ child_id(FK)│◄────────────────────────┘          │
│ rule_id(FK) │                                    │
│ points      │                                    │
│ type        │                                    │
│ note        │                                    │
│ created_at  │                                    │
└─────────────┘                                    │
       │                                           │
       │                                           │
       ▼                                           │
┌─────────────┐                                    │
│  exchanges  │                                    │
├─────────────┤                                    │
│ id (PK)     │                                    │
│ child_id(FK)│                                    │
│ reward_id(FK)◄───────────────────────────────────┘
│ points_spent│
│ note        │
│ created_at  │
└─────────────┘
```

### 2.1 关系说明

| 关系 | 类型 | 说明 |
|------|------|------|
| children → point_records | 1:N | 一个宝贝有多条积分记录 |
| children → exchanges | 1:N | 一个宝贝有多条兑换记录 |
| children → rules | 1:N | 一个宝贝可有多条自定义规则 |
| rules → point_records | 1:N | 一条规则可产生多条积分记录 |
| rewards → exchanges | 1:N | 一个商品可被多次兑换 |
| exchanges → point_records | 1:1 | 一次兑换对应一条消费记录 |

---

## 3. 表结构定义

### 3.1 children（宝贝档案）

存储家庭中所有宝贝的基本信息和积分余额。

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PK, AUTOINCREMENT | 主键 |
| name | TEXT | NOT NULL | 姓名 |
| avatar | TEXT | NULLABLE | 头像URL或本地路径 |
| gender | TEXT | CHECK(gender IN ('boy','girl')) | 性别 |
| birthday | TEXT | NULLABLE | 生日 (ISO8601格式: YYYY-MM-DD) |
| stars | INTEGER | NOT NULL DEFAULT 0 | 当前积分余额 |
| is_deleted | INTEGER | NOT NULL DEFAULT 0 | 软删除标记 (0=正常, 1=已删除) |
| created_at | TEXT | NOT NULL | 创建时间 (ISO8601) |
| updated_at | TEXT | NOT NULL | 更新时间 (ISO8601) |

**业务规则**:
- 删除宝贝时设置 `is_deleted = 1`，不物理删除
- `stars` 字段作为冗余存储，需与 point_records 保持一致

---

### 3.2 rules（积分规则）

存储奖励和惩罚规则的定义。

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PK, AUTOINCREMENT | 主键 |
| child_id | INTEGER | FK → children.id, NULLABLE | 所属宝贝 (NULL=全局规则) |
| name | TEXT | NOT NULL | 规则名称 |
| icon | TEXT | NOT NULL DEFAULT 'star' | Material Symbols 图标名称 |
| points | INTEGER | NOT NULL | 默认分值 (正数) |
| type | TEXT | NOT NULL, CHECK(type IN ('reward','punish')) | 规则类型 |
| is_active | INTEGER | NOT NULL DEFAULT 1 | 启用状态 (0=停用, 1=启用) |
| created_at | TEXT | NOT NULL | 创建时间 |

**业务规则**:
- `child_id = NULL` 表示全局规则，对所有宝贝可用
- `child_id = 具体ID` 表示该宝贝的自定义规则
- `points` 始终存储正数，实际加减由 `type` 决定

---

### 3.3 point_records（积分流水）

记录所有积分变动的明细。

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PK, AUTOINCREMENT | 主键 |
| child_id | INTEGER | FK → children.id, NOT NULL | 所属宝贝 |
| rule_id | INTEGER | FK → rules.id, NULLABLE | 关联规则 (兑换消费时为NULL) |
| exchange_id | INTEGER | FK → exchanges.id, NULLABLE | 关联兑换记录 |
| points | INTEGER | NOT NULL | 实际分值 (正=获得, 负=扣除/消费) |
| type | TEXT | NOT NULL, CHECK(type IN ('earned','deducted','spent')) | 记录类型 |
| note | TEXT | NULLABLE | 备注信息 |
| created_at | TEXT | NOT NULL | 记录时间 |

**类型说明**:
- `earned`: 奖励获得 (points > 0)
- `deducted`: 惩罚扣除 (points < 0)
- `spent`: 兑换消费 (points < 0, exchange_id NOT NULL)

---

### 3.4 rewards（商品/奖励）

存储奖励商城中的商品信息。

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PK, AUTOINCREMENT | 主键 |
| name | TEXT | NOT NULL | 商品名称 |
| description | TEXT | NULLABLE | 商品描述 |
| image | TEXT | NULLABLE | 图片URL或本地路径 |
| price | INTEGER | NOT NULL | 所需星星数 |
| category | TEXT | NOT NULL DEFAULT 'other' | 分类 (privilege/toy/snack/other) |
| stock | INTEGER | NULLABLE | 库存数量 (NULL=无限库存) |
| is_active | INTEGER | NOT NULL DEFAULT 1 | 上架状态 (0=下架, 1=上架) |
| created_at | TEXT | NOT NULL | 创建时间 |

**业务规则**:
- `stock = NULL` 表示无限库存
- `stock = 0` 表示已售罄
- 兑换时需检查 `is_active = 1` 且 `stock > 0 OR stock IS NULL`

---

### 3.5 exchanges（兑换记录）

记录商品兑换历史。

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PK, AUTOINCREMENT | 主键 |
| child_id | INTEGER | FK → children.id, NOT NULL | 兑换宝贝 |
| reward_id | INTEGER | FK → rewards.id, NOT NULL | 兑换商品 |
| reward_snapshot | TEXT | NOT NULL | 商品名称快照 (防止商品删除后无法回溯) |
| points_spent | INTEGER | NOT NULL | 消耗星星数 |
| note | TEXT | NULLABLE | 备注 |
| created_at | TEXT | NOT NULL | 兑换时间 |

**业务规则**:
- `points_spent` 记录兑换时的实际价格（商品价格可能变动）
- `reward_snapshot` 记录兑换时的商品名称
- 创建兑换记录时需同步创建 point_records 消费记录

---

## 4. 索引策略

```sql
-- 积分流水查询优化（按宝贝+时间倒序）
-- 场景：查看某个宝贝的积分历史
CREATE INDEX idx_point_records_child_time
ON point_records(child_id, created_at DESC);

-- 积分流水类型筛选
-- 场景：筛选 All/Earned/Spent 类型
CREATE INDEX idx_point_records_type
ON point_records(child_id, type);

-- 规则查询（全局+宝贝专属）
-- 场景：获取某宝贝可用的所有规则
CREATE INDEX idx_rules_child
ON rules(child_id, type, is_active);

-- 兑换记录查询
-- 场景：查看某宝贝的兑换历史
CREATE INDEX idx_exchanges_child_time
ON exchanges(child_id, created_at DESC);

-- 商品分类筛选
-- 场景：商城按分类浏览商品
CREATE INDEX idx_rewards_category
ON rewards(category, is_active);
```

---

## 5. 关键业务查询

### 5.1 积分仪表盘统计

获取宝贝的积分概览（当前余额、累计获得、累计扣除）。

```sql
SELECT
  c.stars AS current_balance,
  COALESCE(SUM(CASE WHEN pr.type = 'earned' THEN pr.points ELSE 0 END), 0) AS total_earned,
  COALESCE(SUM(CASE WHEN pr.type IN ('deducted', 'spent') THEN ABS(pr.points) ELSE 0 END), 0) AS total_spent
FROM children c
LEFT JOIN point_records pr ON c.id = pr.child_id
WHERE c.id = :childId
GROUP BY c.id;
```

### 5.2 按日期分组的流水列表

获取积分流水并按日期分组显示。

```sql
SELECT
  DATE(pr.created_at) AS record_date,
  pr.id,
  pr.points,
  pr.type,
  pr.note,
  pr.created_at,
  r.name AS rule_name,
  r.icon AS rule_icon
FROM point_records pr
LEFT JOIN rules r ON pr.rule_id = r.id
WHERE pr.child_id = :childId
  AND (:typeFilter IS NULL OR pr.type = :typeFilter)
ORDER BY pr.created_at DESC;
```

### 5.3 获取宝贝可用规则

获取全局规则 + 宝贝自定义规则。

```sql
SELECT * FROM rules
WHERE (child_id IS NULL OR child_id = :childId)
  AND is_active = 1
  AND type = :ruleType
ORDER BY child_id NULLS LAST, name;
```

### 5.4 商品兑换事务

兑换商品的完整事务流程。

```sql
-- 开启事务
BEGIN TRANSACTION;

-- 1. 检查商品状态和库存
SELECT id, name, price, stock FROM rewards
WHERE id = :rewardId AND is_active = 1
  AND (stock IS NULL OR stock > 0);

-- 2. 检查宝贝余额
SELECT stars FROM children WHERE id = :childId AND stars >= :price;

-- 3. 扣减库存（如果有限）
UPDATE rewards
SET stock = stock - 1
WHERE id = :rewardId AND stock IS NOT NULL;

-- 4. 创建兑换记录
INSERT INTO exchanges (child_id, reward_id, reward_snapshot, points_spent, note, created_at)
VALUES (:childId, :rewardId, :rewardName, :price, :note, :now);

-- 5. 扣减积分
UPDATE children
SET stars = stars - :price, updated_at = :now
WHERE id = :childId;

-- 6. 创建积分流水
INSERT INTO point_records (child_id, exchange_id, points, type, created_at)
VALUES (:childId, last_insert_rowid(), -:price, 'spent', :now);

-- 提交事务
COMMIT;
```

### 5.5 兑换统计

获取宝贝的兑换统计信息。

```sql
SELECT
  COUNT(*) AS total_exchanges,
  COALESCE(SUM(points_spent), 0) AS total_points_spent
FROM exchanges
WHERE child_id = :childId;
```

---

## 6. Drift 代码实现

### 6.1 表定义 (lib/database/tables.dart)

```dart
import 'package:drift/drift.dart';

/// 宝贝档案表
class Children extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get avatar => text().nullable()();
  TextColumn get gender => text().check(gender.isIn(['boy', 'girl']))();
  TextColumn get birthday => text().nullable()();
  IntColumn get stars => integer().withDefault(const Constant(0))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// 积分规则表
class Rules extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get childId => integer().nullable().references(Children, #id)();
  TextColumn get name => text()();
  TextColumn get icon => text().withDefault(const Constant('star'))();
  IntColumn get points => integer()();
  TextColumn get type => text().check(type.isIn(['reward', 'punish']))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
}

/// 积分流水表
class PointRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get childId => integer().references(Children, #id)();
  IntColumn get ruleId => integer().nullable().references(Rules, #id)();
  IntColumn get exchangeId => integer().nullable().references(Exchanges, #id)();
  IntColumn get points => integer()();
  TextColumn get type => text().check(type.isIn(['earned', 'deducted', 'spent']))();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

/// 商品表
class Rewards extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get image => text().nullable()();
  IntColumn get price => integer()();
  TextColumn get category => text().withDefault(const Constant('other'))();
  IntColumn get stock => integer().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
}

/// 兑换记录表
class Exchanges extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get childId => integer().references(Children, #id)();
  IntColumn get rewardId => integer().references(Rewards, #id)();
  TextColumn get rewardSnapshot => text()();
  IntColumn get pointsSpent => integer()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}
```

### 6.2 数据库配置 (lib/database/database.dart)

```dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Children, Rules, PointRecords, Rewards, Exchanges])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // 初始化默认规则
        await _seedDefaultRules();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // 未来版本迁移逻辑
      },
    );
  }

  Future<void> _seedDefaultRules() async {
    final defaultRewardRules = [
      RulesCompanion.insert(
        name: 'Complete Homework',
        icon: const Value('menu_book'),
        points: 10,
        type: 'reward',
        createdAt: DateTime.now(),
      ),
      RulesCompanion.insert(
        name: 'Help with Chores',
        icon: const Value('cleaning_services'),
        points: 15,
        type: 'reward',
        createdAt: DateTime.now(),
      ),
      RulesCompanion.insert(
        name: 'Good Behavior',
        icon: const Value('sentiment_satisfied'),
        points: 5,
        type: 'reward',
        createdAt: DateTime.now(),
      ),
    ];

    final defaultPunishRules = [
      RulesCompanion.insert(
        name: 'Bad Attitude',
        icon: const Value('sentiment_dissatisfied'),
        points: 10,
        type: 'punish',
        createdAt: DateTime.now(),
      ),
      RulesCompanion.insert(
        name: 'Not Listening',
        icon: const Value('hearing_disabled'),
        points: 5,
        type: 'punish',
        createdAt: DateTime.now(),
      ),
    ];

    await batch((batch) {
      batch.insertAll(rules, [...defaultRewardRules, ...defaultPunishRules]);
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'children_rewards.db'));
    return NativeDatabase.createInBackground(file);
  });
}
```

### 6.3 依赖配置 (pubspec.yaml 相关部分)

```yaml
dependencies:
  drift: ^2.14.0
  sqlite3_flutter_libs: ^0.5.18
  path_provider: ^2.1.1
  path: ^1.8.3

dev_dependencies:
  drift_dev: ^2.14.0
  build_runner: ^2.4.7
```

---

## 7. 数据迁移策略

### 7.1 版本升级示例

```dart
@override
MigrationStrategy get migration {
  return MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // v1 -> v2: 添加新字段示例
        await m.addColumn(children, children.newField);
      }
      if (from < 3) {
        // v2 -> v3: 添加新表示例
        await m.createTable(newTable);
      }
    },
  );
}
```

### 7.2 数据备份与恢复

```dart
/// 导出数据库为 JSON
Future<String> exportToJson() async {
  final allChildren = await select(children).get();
  final allRules = await select(rules).get();
  final allRecords = await select(pointRecords).get();
  final allRewards = await select(rewards).get();
  final allExchanges = await select(exchanges).get();

  return jsonEncode({
    'version': schemaVersion,
    'exportedAt': DateTime.now().toIso8601String(),
    'children': allChildren.map((e) => e.toJson()).toList(),
    'rules': allRules.map((e) => e.toJson()).toList(),
    'pointRecords': allRecords.map((e) => e.toJson()).toList(),
    'rewards': allRewards.map((e) => e.toJson()).toList(),
    'exchanges': allExchanges.map((e) => e.toJson()).toList(),
  });
}
```

---

## 8. 技术实现备忘录 (Architecture Decision Records)

### 8.1 统一图标系统架构 (Icon System)

**背景**: 数据库仅存储图标的字符串 key（如 `menu_book`），Flutter 需将其渲染为 `IconData`。

**决策**:
- 创建 `AppIcons` 注册表单例。
- 维护 `Map<String, IconData>` 映射。
- UI 层统一调用 `AppIcons.get(key)` 获取图标，避免硬编码。
- 未来扩展图片上传时，在 UI 组件层做适配。

### 8.2 健壮的事务层 (Transaction Repository)

**背景**: 商品兑换涉及多表操作（扣库存、扣余额、写记录），直接在 UI 逻辑中处理不安全。

**决策**:
- **Repository 层封装**：所有跨表写操作必须封装在 Repository 方法中。
- **Drift 事务**：使用 `db.transaction(() async { ... })` 包裹逻辑。
- **悲观检查**：在事务内部再次查询余额和库存，防止并发问题。

### 8.3 强类型资源管理

**背景**: 避免 `assets/images/logo.png` 或 `AppStrings.title` 拼写错误。

**决策**:
- 使用 `flutter_gen` 或 `flutter_localizations`。
- 所有资源引用必须通过生成的类型安全类访问。

---

## 9. 附录

### 9.1 分类枚举值

| 字段 | 可选值 | 说明 |
|------|--------|------|
| children.gender | boy, girl | 性别 |
| rules.type | reward, punish | 规则类型 |
| point_records.type | earned, deducted, spent | 积分变动类型 |
| rewards.category | privilege, toy, snack, other | 商品分类 |

### 9.2 图标参考

使用 Google Material Symbols Rounded 图标库，常用图标：

| 图标名称 | 用途 |
|----------|------|
| star | 默认/积分 |
| menu_book | 学习/作业 |
| cleaning_services | 家务 |
| sentiment_satisfied | 好行为 |
| sentiment_dissatisfied | 坏行为 |
| sports_esports | 游戏 |
| cake | 零食 |
| card_giftcard | 礼物 |

---

*文档结束*

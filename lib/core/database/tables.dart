import 'package:drift/drift.dart';

/// 宝贝档案表
class Children extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get avatar => text().nullable()();
  TextColumn get gender => text().customConstraint("NOT NULL CHECK(gender IN ('boy','girl'))")();
  TextColumn get birthday => text().nullable()();
  IntColumn get stars => integer().withDefault(const Constant(0)).customConstraint("NOT NULL DEFAULT 0 CHECK(stars >= 0)")();
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
  IntColumn get points => integer().customConstraint("NOT NULL CHECK(points > 0)")();
  TextColumn get type => text().withDefault(const Constant('reward'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isSystem => boolean().withDefault(const Constant(false))();
  BoolColumn get isEditable => boolean().withDefault(const Constant(true))(); // 是否可编辑
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

/// 商品表
class Rewards extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get image => text().nullable()();
  IntColumn get price => integer().customConstraint("NOT NULL CHECK(price > 0)")();
  TextColumn get category => text().withDefault(const Constant('other'))();
  IntColumn get stock => integer().nullable().customConstraint("CHECK(stock IS NULL OR stock >= 0)")();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

/// 兑换记录表
class Exchanges extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get childId => integer().references(Children, #id)();
  IntColumn get rewardId => integer().references(Rewards, #id)();
  TextColumn get rewardSnapshot => text()();
  IntColumn get pointsSpent => integer()();
  TextColumn get note => text().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

/// 积分流水表
class PointRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get childId => integer().references(Children, #id)();
  IntColumn get ruleId => integer().nullable().references(Rules, #id)();
  TextColumn get ruleName => text().nullable()(); // 规则名称冗余存储
  IntColumn get exchangeId => integer().nullable().references(Exchanges, #id)();
  IntColumn get points => integer()(); // Can be negative
  TextColumn get type => text().customConstraint("NOT NULL CHECK(type IN ('earned','deducted','spent'))")();
  TextColumn get note => text().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

/// 应用内容表（存储隐私协议等）
class AppContents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().unique()(); // 内容标识：privacy_policy, terms_of_service 等
  TextColumn get titleEn => text()(); // 英文标题
  TextColumn get titleZh => text()(); // 中文标题
  TextColumn get contentEn => text()(); // 英文内容
  TextColumn get contentZh => text()(); // 中文内容
  IntColumn get version => integer().withDefault(const Constant(1))(); // 版本号
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

/// 应用日志表
class AppLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get level => text()(); // debug, info, warning, error
  TextColumn get tag => text()(); // 模块标签：database, ui, network 等
  TextColumn get message => text()(); // 日志消息
  TextColumn get stackTrace => text().nullable()(); // 错误堆栈（可选）
  TextColumn get extra => text().nullable()(); // 额外数据 JSON（可选）
  DateTimeColumn get createdAt => dateTime()();
}

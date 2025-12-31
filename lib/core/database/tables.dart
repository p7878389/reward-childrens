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

/// 应用设置表（存储启动标记等）
class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().unique()(); // 设置标识：first_launch_done 等
  TextColumn get value => text()(); // 设置值
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

/// 徽章定义表
class Badges extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()(); // 徽章名称
  TextColumn get description => text().nullable()(); // 描述
  TextColumn get icon => text()(); // 图标标识
  IntColumn get level => integer().withDefault(const Constant(1))(); // 等级

  // 触发条件
  TextColumn get triggerType => text()(); // 条件类型枚举
  IntColumn get triggerThreshold => integer()(); // 阈值
  TextColumn get triggerConfig => text().nullable()(); // 扩展配置(JSON)

  IntColumn get bonusPoints =>
      integer().withDefault(const Constant(0))(); // 奖励积分
  IntColumn get sortOrder => integer().withDefault(const Constant(0))(); // 排序
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isSystem => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

/// 徽章获得记录表
class BadgeAcquisitions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get childId => integer().references(Children, #id)();
  IntColumn get badgeId => integer().references(Badges, #id)();
  TextColumn get badgeSnapshot => text()(); // 徽章快照(JSON)
  IntColumn get bonusPointsAwarded => integer()(); // 发放的奖励积分
  IntColumn get pointRecordId => integer().nullable()(); // 关联积分流水
  IntColumn get triggerValue => integer().nullable()(); // 触发时的实际值
  TextColumn get note => text().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

/// 签到记录表（支持连续签到徽章）
class CheckinRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get childId => integer().references(Children, #id)();
  TextColumn get checkinDate => text()(); // 签到日期 YYYY-MM-DD
  IntColumn get streakDays => integer()(); // 连续天数
  IntColumn get pointRecordId => integer().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}

// ============ 成语接龙游戏相关表 ============

/// 成语表
@TableIndex(name: 'idx_idioms_first_pinyin', columns: {#firstPinyinNoTone})
@TableIndex(name: 'idx_idioms_last_pinyin', columns: {#lastPinyinNoTone})
@TableIndex(name: 'idx_idioms_first_char', columns: {#firstChar})
@TableIndex(name: 'idx_idioms_last_char', columns: {#lastChar})
@TableIndex(name: 'idx_idioms_grade', columns: {#gradeLevel})
@TableIndex(name: 'idx_idioms_rare', columns: {#isRare})
@TableIndex(name: 'idx_idioms_first_pinyin_tone', columns: {#firstPinyin})
@TableIndex(name: 'idx_idioms_last_pinyin_tone', columns: {#lastPinyin})
class Idioms extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text().withLength(min: 2, max: 12)();
  TextColumn get pinyin => text()();
  TextColumn get firstPinyinNoTone => text().withLength(max: 30)();
  TextColumn get lastPinyinNoTone => text().withLength(max: 30)();
  TextColumn get firstPinyin => text().withLength(max: 10).withDefault(const Constant(''))(); // 首字拼音（带声调）
  TextColumn get lastPinyin => text().withLength(max: 10).withDefault(const Constant(''))();  // 尾字拼音（带声调）
  TextColumn get firstChar => text().withLength(max: 4)();
  TextColumn get lastChar => text().withLength(max: 4)();
  TextColumn get explanation => text().nullable()();
  TextColumn get source => text().nullable()();
  TextColumn get example => text().nullable()();
  IntColumn get gradeLevel => integer().withDefault(const Constant(1))();
  IntColumn get frequency => integer().withDefault(const Constant(50))();
  BoolColumn get isRare => boolean().withDefault(const Constant(false))(); // 生僻成语标识
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  @override
  List<Set<Column>> get uniqueKeys => [{word}];
}

/// 成语游戏配置表
class IdiomGameSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get childId => integer().references(Children, #id)();
  IntColumn get currentGrade => integer().withDefault(const Constant(1))();
  IntColumn get customCountdown => integer().nullable()();
  IntColumn get customFreeHints => integer().nullable()();
  /// 接龙匹配模式: 0=正常接龙(首字=尾字), 1=包含尾字, 2=同音接龙(声调一致)
  IntColumn get matchMode => integer().withDefault(const Constant(0))();
  BoolColumn get soundEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get includeRareIdioms => boolean().withDefault(const Constant(false))(); // 是否包含生僻成语
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

/// 成语游戏记录表
class IdiomGameRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get childId => integer().references(Children, #id)();
  IntColumn get grade => integer()();
  IntColumn get score => integer()();
  IntColumn get chainLength => integer()();
  IntColumn get duration => integer()();
  IntColumn get hintsUsed => integer().withDefault(const Constant(0))();
  IntColumn get fastAnswerCount => integer().withDefault(const Constant(0))();
  IntColumn get rareIdiomCount => integer().withDefault(const Constant(0))();
  IntColumn get playerTurns => integer().withDefault(const Constant(0))();
  IntColumn get timeoutWarningCount => integer().withDefault(const Constant(0))();
  BoolColumn get isAiSurrender => boolean().withDefault(const Constant(false))();
  IntColumn get comboMax => integer().withDefault(const Constant(0))();
  IntColumn get starsEarned => integer().withDefault(const Constant(0))();
  IntColumn get starRating => integer().withDefault(const Constant(0))();
  TextColumn get idiomChain => text().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get playedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
}

/// 年级解锁进度表
class IdiomGradeProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get childId => integer().references(Children, #id)();
  IntColumn get grade => integer()();
  IntColumn get highScore => integer().withDefault(const Constant(0))();
  IntColumn get bestChainLength => integer().withDefault(const Constant(0))();
  IntColumn get starRating => integer().withDefault(const Constant(0))();
  IntColumn get playCount => integer().withDefault(const Constant(0))();
  BoolColumn get isUnlocked => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  @override
  List<Set<Column>> get uniqueKeys => [{childId, grade}];
}

/// 成语接龙失败记录表（用于针对性出题）
@TableIndex(name: 'idx_idiom_failures_child', columns: {#childId})
@TableIndex(name: 'idx_idiom_failures_last_char', columns: {#lastChar})
class IdiomFailureRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get childId => integer().references(Children, #id)();
  TextColumn get lastChar => text().withLength(max: 4)(); // 失败时的成语尾字
  IntColumn get failCount => integer().withDefault(const Constant(1))(); // 失败次数
  IntColumn get successCount => integer().withDefault(const Constant(0))(); // 成功次数（多次成功后可移除）
  DateTimeColumn get lastFailedAt => dateTime()(); // 最后失败时间
  DateTimeColumn get lastSuccessAt => dateTime().nullable()(); // 最后成功时间
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  @override
  List<Set<Column>> get uniqueKeys => [{childId, lastChar}];
}

/// 成语补全/猜意思游戏记录表
class IdiomPuzzleRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get childId => integer().references(Children, #id)();
  TextColumn get gameMode => text()();  // 'completion' | 'meaning'
  IntColumn get grade => integer()();
  IntColumn get correctCount => integer()();
  IntColumn get totalCount => integer()();
  IntColumn get starsEarned => integer()();
  IntColumn get timeTakenSeconds => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get playedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
}

/// 游戏互动记录表 (用于追踪单个成语的掌握情况)
@TableIndex(name: 'idx_engagement_child_idiom', columns: {#childId, #idiomId}, unique: true)
@TableIndex(name: 'idx_review_queue', columns: {#childId, #masteryLevel, #lastWrongAt})
class IdiomEngagementRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get childId => integer().references(Children, #id)();
  IntColumn get idiomId => integer().references(Idioms, #id)();
  IntColumn get encounterCount => integer().withDefault(const Constant(1))(); // 遇到次数
  IntColumn get correctCount => integer().withDefault(const Constant(0))(); // 答对次数
  IntColumn get failCount => integer().withDefault(const Constant(0))();    // 答错次数
  DateTimeColumn get lastEncounteredAt => dateTime()();
  
  // SRS (间隔重复系统) 字段
  DateTimeColumn get lastWrongAt => dateTime().nullable()(); // 上次答错时间
  IntColumn get masteryLevel => integer().withDefault(const Constant(0))(); // 掌握等级 (0-3)
  IntColumn get consecutiveCorrect => integer().withDefault(const Constant(0))(); // 连续答对次数
}

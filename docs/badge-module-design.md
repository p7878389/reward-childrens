# 成长徽章模块技术方案

## 需求概述

设计一个可扩展的徽章系统：
- **自定义徽章**：图标、名称、描述、等级
- **灵活触发条件**：累计积分、连续签到、兑换次数等
- **关联奖励**：获得徽章时发放额外积分
- **徽章展示**：在孩子档案页展示

---

## 一、架构设计

```
┌─────────────────────────────────────────────────────────────────┐
│                     Badge Detection Engine                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  触发事件                    检测引擎                   授予服务   │
│  ┌─────────────────┐    ┌──────────────────┐    ┌─────────────┐ │
│  │ 积分变动         │───>│                  │───>│ 创建获得记录 │ │
│  │ 兑换完成         │    │  BadgeDetector   │    │ 发放奖励积分 │ │
│  │ 签到完成         │    │                  │    │ 弹窗通知    │ │
│  └─────────────────┘    └────────┬─────────┘    └─────────────┘ │
│                                  │                               │
│                    ┌─────────────┼─────────────┐                │
│                    ▼             ▼             ▼                │
│              ┌──────────┐  ┌──────────┐  ┌──────────┐          │
│              │累计积分   │  │连续签到   │  │兑换次数   │          │
│              │Evaluator │  │Evaluator │  │Evaluator │          │
│              └──────────┘  └──────────┘  └──────────┘          │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

---

## 二、数据模型设计

### 2.1 新增数据库表

```dart
// lib/core/database/tables.dart 新增

/// 徽章定义表
class Badges extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();                    // 徽章名称
  TextColumn get description => text().nullable()(); // 描述
  TextColumn get icon => text()();                   // 图标标识
  IntColumn get level => integer().withDefault(const Constant(1))(); // 等级

  // 触发条件
  TextColumn get triggerType => text()();            // 条件类型枚举
  IntColumn get triggerThreshold => integer()();     // 阈值
  TextColumn get triggerConfig => text().nullable()(); // 扩展配置(JSON)

  IntColumn get bonusPoints => integer().withDefault(const Constant(0))(); // 奖励积分
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();   // 排序
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
  TextColumn get badgeSnapshot => text()();          // 徽章快照(JSON)
  IntColumn get bonusPointsAwarded => integer()();   // 发放的奖励积分
  IntColumn get pointRecordId => integer().nullable()(); // 关联积分流水
  IntColumn get triggerValue => integer().nullable()();  // 触发时的实际值
  TextColumn get note => text().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

/// 签到记录表（支持连续签到徽章）
class CheckinRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get childId => integer().references(Children, #id)();
  TextColumn get checkinDate => text()();            // 签到日期 YYYY-MM-DD
  IntColumn get streakDays => integer()();           // 连续天数
  IntColumn get pointRecordId => integer().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}
```

### 2.2 触发条件类型

| 类型 | 枚举值 | 说明 | 示例 |
|------|--------|------|------|
| 累计积分 | `total_points` | 累计获得积分达到阈值 | 累计1000星获得"星光璀璨" |
| 连续签到 | `consecutive_checkin` | 连续签到天数达到阈值 | 连续7天获得"坚持一周" |
| 兑换次数 | `exchange_count` | 兑换商品次数达到阈值 | 兑换10次获得"购物达人" |
| 单次积分 | `points_earned_single` | 单次获得积分达到阈值 | 单次50星获得"大有作为" |
| 自定义 | `custom` | 预留扩展 | - |

### 2.3 触发条件配置 Schema（triggerConfig JSON 格式）

```json
// 累计积分类型
{
  "pointType": "all"  // all: 所有积分, earned: 仅获得的, spent: 仅消费的
}

// 连续签到类型
{
  "allowMakeup": false,  // 是否允许补签
  "resetOnMiss": true    // 断签是否重置连续天数
}

// 兑换次数类型
{
  "categoryFilter": null,  // null: 所有类别, 或指定类别
  "minPrice": 0            // 最低兑换积分限制
}

// 单次获得积分类型
{
  "ruleTypeFilter": null   // null: 所有规则, 或指定规则类型
}
```

---

## 三、领域实体设计

### 3.1 徽章实体

```dart
// lib/features/badges/domain/entities/badge_entity.dart

/// 徽章触发条件类型枚举
enum BadgeTriggerType {
  totalPoints('total_points'),           // 累计获得积分
  consecutiveCheckin('consecutive_checkin'), // 连续签到
  exchangeCount('exchange_count'),       // 兑换次数
  pointsEarnedSingle('points_earned_single'), // 单次积分
  custom('custom');                      // 自定义

  final String value;
  const BadgeTriggerType(this.value);

  static BadgeTriggerType fromString(String value) {
    return BadgeTriggerType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => BadgeTriggerType.custom,
    );
  }
}

/// 徽章领域实体
@immutable
class BadgeEntity {
  final int id;
  final String name;
  final String? description;
  final String icon;
  final int level;
  final BadgeTriggerType triggerType;
  final int triggerThreshold;
  final Map<String, dynamic>? triggerConfig;
  final int bonusPoints;
  final int sortOrder;
  final bool isActive;
  final bool isSystem;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const BadgeEntity({...});

  /// 检查是否为有效徽章
  bool get isValid => isActive && !isDeleted;

  /// 获取触发条件的描述文本
  String get triggerDescription {
    switch (triggerType) {
      case BadgeTriggerType.totalPoints:
        return '累计获得 $triggerThreshold 颗星星';
      case BadgeTriggerType.consecutiveCheckin:
        return '连续签到 $triggerThreshold 天';
      case BadgeTriggerType.exchangeCount:
        return '兑换商品 $triggerThreshold 次';
      case BadgeTriggerType.pointsEarnedSingle:
        return '单次获得 $triggerThreshold 颗星星';
      case BadgeTriggerType.custom:
        return description ?? '完成特定任务';
    }
  }
}
```

### 3.2 徽章获得记录实体

```dart
// lib/features/badges/domain/entities/badge_acquisition_entity.dart

@immutable
class BadgeAcquisitionEntity {
  final int id;
  final int childId;
  final int badgeId;
  final String badgeSnapshot;
  final int bonusPointsAwarded;
  final int? pointRecordId;
  final int? triggerValue;
  final String? note;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const BadgeAcquisitionEntity({...});

  bool get hasBonusPoints => bonusPointsAwarded > 0;
}
```

---

## 四、触发条件引擎架构

### 4.1 条件评估器接口

```dart
// lib/features/badges/domain/evaluators/badge_condition_evaluator.dart

/// 徽章条件评估结果
class BadgeEvaluationResult {
  final bool isSatisfied;      // 是否满足条件
  final int currentValue;      // 当前进度值
  final int targetThreshold;   // 目标阈值

  double get progress =>
      targetThreshold > 0 ? (currentValue / targetThreshold).clamp(0.0, 1.0) : 0.0;

  const BadgeEvaluationResult({...});
}

/// 徽章条件评估器抽象接口（策略模式）
abstract class IBadgeConditionEvaluator {
  BadgeTriggerType get supportedType;
  Future<BadgeEvaluationResult> evaluate(int childId, BadgeEntity badge);
}
```

### 4.2 各类型评估器实现

```dart
// 累计积分评估器
class TotalPointsEvaluator implements IBadgeConditionEvaluator {
  final IPointRecordsRepository _pointRecordsRepository;

  @override
  BadgeTriggerType get supportedType => BadgeTriggerType.totalPoints;

  @override
  Future<BadgeEvaluationResult> evaluate(int childId, BadgeEntity badge) async {
    final stats = await _pointRecordsRepository.getStats(childId);
    final totalEarned = stats['earned'] ?? 0;
    return BadgeEvaluationResult(
      isSatisfied: totalEarned >= badge.triggerThreshold,
      currentValue: totalEarned,
      targetThreshold: badge.triggerThreshold,
    );
  }
}

// 连续签到评估器
class ConsecutiveCheckinEvaluator implements IBadgeConditionEvaluator {
  final ICheckinRepository _checkinRepository;

  @override
  BadgeTriggerType get supportedType => BadgeTriggerType.consecutiveCheckin;

  @override
  Future<BadgeEvaluationResult> evaluate(int childId, BadgeEntity badge) async {
    final currentStreak = await _checkinRepository.getCurrentStreak(childId);
    return BadgeEvaluationResult(
      isSatisfied: currentStreak >= badge.triggerThreshold,
      currentValue: currentStreak,
      targetThreshold: badge.triggerThreshold,
    );
  }
}

// 兑换次数评估器
class ExchangeCountEvaluator implements IBadgeConditionEvaluator {
  final IExchangeRepository _exchangeRepository;

  @override
  BadgeTriggerType get supportedType => BadgeTriggerType.exchangeCount;

  @override
  Future<BadgeEvaluationResult> evaluate(int childId, BadgeEntity badge) async {
    final exchangeCount = await _exchangeRepository.getExchangeCount(childId);
    return BadgeEvaluationResult(
      isSatisfied: exchangeCount >= badge.triggerThreshold,
      currentValue: exchangeCount,
      targetThreshold: badge.triggerThreshold,
    );
  }
}

// 单次积分评估器
class SinglePointsEvaluator implements IBadgeConditionEvaluator {
  int? _currentSinglePoints;

  @override
  BadgeTriggerType get supportedType => BadgeTriggerType.pointsEarnedSingle;

  void setContext({required int singlePoints}) {
    _currentSinglePoints = singlePoints;
  }

  @override
  Future<BadgeEvaluationResult> evaluate(int childId, BadgeEntity badge) async {
    final points = _currentSinglePoints ?? 0;
    return BadgeEvaluationResult(
      isSatisfied: points >= badge.triggerThreshold,
      currentValue: points,
      targetThreshold: badge.triggerThreshold,
    );
  }
}
```

### 4.3 评估器工厂

```dart
// lib/features/badges/domain/evaluators/badge_evaluator_factory.dart

class BadgeEvaluatorFactory {
  final Map<BadgeTriggerType, IBadgeConditionEvaluator> _evaluators = {};

  void register(IBadgeConditionEvaluator evaluator) {
    _evaluators[evaluator.supportedType] = evaluator;
  }

  IBadgeConditionEvaluator? getEvaluator(BadgeTriggerType type) {
    return _evaluators[type];
  }

  bool supports(BadgeTriggerType type) => _evaluators.containsKey(type);
}
```

### 4.4 徽章检测服务

```dart
// lib/features/badges/domain/services/badge_detection_service.dart

class PendingBadgeAward {
  final BadgeEntity badge;
  final int triggerValue;
  const PendingBadgeAward({required this.badge, required this.triggerValue});
}

class BadgeDetectionService {
  final IBadgeRepository _badgeRepository;
  final IBadgeAcquisitionRepository _acquisitionRepository;
  final BadgeEvaluatorFactory _evaluatorFactory;

  /// 检测孩子可获得的新徽章
  Future<List<PendingBadgeAward>> detectNewBadges(
    int childId, {
    List<BadgeTriggerType>? triggerTypes,
  }) async {
    final pendingAwards = <PendingBadgeAward>[];

    // 1. 获取所有有效徽章
    final allBadges = await _badgeRepository.getActiveBadges();

    // 2. 获取该孩子已获得的徽章ID集合
    final acquiredBadgeIds = await _acquisitionRepository.getAcquiredBadgeIds(childId);

    // 3. 筛选尚未获得且符合触发类型的徽章
    final candidateBadges = allBadges.where((badge) {
      final notAcquired = !acquiredBadgeIds.contains(badge.id);
      final typeMatch = triggerTypes == null || triggerTypes.contains(badge.triggerType);
      return notAcquired && typeMatch;
    }).toList();

    // 4. 逐个评估
    for (final badge in candidateBadges) {
      final evaluator = _evaluatorFactory.getEvaluator(badge.triggerType);
      if (evaluator == null) continue;

      final result = await evaluator.evaluate(childId, badge);
      if (result.isSatisfied) {
        pendingAwards.add(PendingBadgeAward(
          badge: badge,
          triggerValue: result.currentValue,
        ));
      }
    }

    return pendingAwards;
  }
}
```

---

## 五、关键用例设计

### 5.1 用例列表

| 用例 | 职责 | 触发时机 |
|------|------|----------|
| `CheckAndAwardBadgesUseCase` | 检测并授予徽章（核心） | 积分/兑换/签到后 |
| `AwardBadgeUseCase` | 授予单个徽章 | 内部调用 |
| `GetChildBadgesUseCase` | 获取孩子的徽章列表 | 档案页展示 |
| `GetBadgeProgressUseCase` | 获取徽章进度 | 进度展示 |
| `CreateBadgeUseCase` | 创建新徽章定义 | 管理功能 |
| `UpdateBadgeUseCase` | 更新徽章定义 | 管理功能 |
| `DeleteBadgeUseCase` | 删除徽章定义（软删除） | 管理功能 |
| `CheckinUseCase` | 签到操作 | 每日签到 |

### 5.2 核心用例：检测并授予徽章

```dart
// lib/features/badges/domain/usecases/check_and_award_badges_usecase.dart

/// 触发点枚举
enum BadgeTriggerPoint {
  afterPointRecordCreated,  // 积分记录创建后
  afterExchangeCompleted,   // 兑换完成后
  afterCheckinCompleted,    // 签到完成后
  manualCheck,              // 手动触发检测
}

class CheckAndAwardBadgesParams {
  final int childId;
  final BadgeTriggerPoint triggerPoint;
  final Map<String, dynamic>? context;
  const CheckAndAwardBadgesParams({...});
}

class BadgeAwardResult {
  final List<BadgeEntity> awardedBadges;
  final int totalBonusPoints;
  const BadgeAwardResult({...});
  bool get hasBadges => awardedBadges.isNotEmpty;
}

class CheckAndAwardBadgesUseCase extends UseCase<CheckAndAwardBadgesParams, BadgeAwardResult> {
  final BadgeDetectionService _detectionService;
  final AwardBadgeUseCase _awardBadgeUseCase;

  @override
  Future<Result<BadgeAwardResult>> execute(CheckAndAwardBadgesParams params) async {
    try {
      // 1. 根据触发点确定要检测的徽章类型
      final triggerTypes = _getTriggerTypesForPoint(params.triggerPoint);

      // 2. 检测可获得的徽章
      final pendingAwards = await _detectionService.detectNewBadges(
        params.childId,
        triggerTypes: triggerTypes,
      );

      if (pendingAwards.isEmpty) {
        return Result.success(const BadgeAwardResult(
          awardedBadges: [],
          totalBonusPoints: 0,
        ));
      }

      // 3. 逐个授予徽章
      final awardedBadges = <BadgeEntity>[];
      var totalBonusPoints = 0;

      for (final pending in pendingAwards) {
        final awardResult = await _awardBadgeUseCase.execute(AwardBadgeParams(
          childId: params.childId,
          badge: pending.badge,
          triggerValue: pending.triggerValue,
        ));

        if (awardResult.isSuccess) {
          awardedBadges.add(pending.badge);
          totalBonusPoints += pending.badge.bonusPoints;
        }
      }

      return Result.success(BadgeAwardResult(
        awardedBadges: awardedBadges,
        totalBonusPoints: totalBonusPoints,
      ));
    } catch (e, stackTrace) {
      return Result.failure('徽章检测失败', stackTrace: stackTrace);
    }
  }

  List<BadgeTriggerType>? _getTriggerTypesForPoint(BadgeTriggerPoint point) {
    switch (point) {
      case BadgeTriggerPoint.afterPointRecordCreated:
        return [BadgeTriggerType.totalPoints, BadgeTriggerType.pointsEarnedSingle];
      case BadgeTriggerPoint.afterExchangeCompleted:
        return [BadgeTriggerType.exchangeCount];
      case BadgeTriggerPoint.afterCheckinCompleted:
        return [BadgeTriggerType.consecutiveCheckin];
      case BadgeTriggerPoint.manualCheck:
        return null; // 检测所有类型
    }
  }
}
```

### 5.3 授予徽章用例

```dart
// lib/features/badges/domain/usecases/award_badge_usecase.dart

class AwardBadgeParams {
  final int childId;
  final BadgeEntity badge;
  final int triggerValue;
  final String? note;
  const AwardBadgeParams({...});
}

class AwardBadgeUseCase extends UseCase<AwardBadgeParams, void> {
  final IBadgeAcquisitionRepository _acquisitionRepository;
  final IPointRecordsRepository _pointRecordsRepository;

  @override
  Future<Result<void>> execute(AwardBadgeParams params) async {
    try {
      int? pointRecordId;

      // 1. 如有奖励积分，先创建积分记录
      if (params.badge.bonusPoints > 0) {
        pointRecordId = await _pointRecordsRepository.addRecordAndReturnId(
          childId: params.childId,
          points: params.badge.bonusPoints,
          type: 'earned',
          ruleName: '徽章奖励：${params.badge.name}',
          note: '获得徽章【${params.badge.name}】的奖励积分',
        );
      }

      // 2. 创建徽章获得记录
      await _acquisitionRepository.create(
        childId: params.childId,
        badgeId: params.badge.id,
        badgeSnapshot: jsonEncode({
          'name': params.badge.name,
          'icon': params.badge.icon,
          'level': params.badge.level,
        }),
        bonusPointsAwarded: params.badge.bonusPoints,
        pointRecordId: pointRecordId,
        triggerValue: params.triggerValue,
        note: params.note,
      );

      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure('授予徽章失败', stackTrace: stackTrace);
    }
  }
}
```

---

## 六、与现有模块集成

### 6.1 集成点设计图

```
┌─────────────────────────────────────────────────────────────────┐
│                      Integration Points                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─────────────────┐                                             │
│  │  ApplyRuleUseCase │ ─────────┐                                │
│  │  (积分规则应用)    │          │                                │
│  └─────────────────┘          ▼                                │
│                         ┌───────────────────────┐               │
│  ┌─────────────────┐    │                       │               │
│  │ExchangeRewardUseCase│──>│ CheckAndAwardBadges │               │
│  │    (商品兑换)      │    │      UseCase        │               │
│  └─────────────────┘    │   (徽章检测授予)       │               │
│                         │                       │               │
│  ┌─────────────────┐    └───────────────────────┘               │
│  │  CheckinUseCase  │ ─────────┘                                │
│  │    (每日签到)     │                                           │
│  └─────────────────┘                                            │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

### 6.2 修改 ApplyRuleUseCase（积分规则）

```dart
// lib/features/rule/domain/usecases/apply_rule_usecase.dart（修改后）

class ApplyRuleUseCase extends UseCase<ApplyRuleParams, ApplyRuleResult> {
  final IPointRecordsRepository _pointRecordsRepository;
  final CheckAndAwardBadgesUseCase _checkBadgesUseCase;  // 新增依赖

  @override
  Future<Result<ApplyRuleResult>> execute(ApplyRuleParams params) async {
    try {
      // 1. 添加积分记录（现有逻辑）
      await _pointRecordsRepository.addRecord(
        childId: params.childId,
        points: params.points,
        type: params.type,
        ruleId: params.ruleId,
        ruleName: params.ruleName,
        note: params.note,
      );

      // 2. 新增：触发徽章检测
      BadgeAwardResult? badgeResult;
      if (params.type == 'earned') {
        final checkResult = await _checkBadgesUseCase.execute(
          CheckAndAwardBadgesParams(
            childId: params.childId,
            triggerPoint: BadgeTriggerPoint.afterPointRecordCreated,
            context: {'singlePoints': params.points},
          ),
        );
        badgeResult = checkResult.dataOrNull;
      }

      return Result.success(ApplyRuleResult(
        success: true,
        awardedBadges: badgeResult?.awardedBadges ?? [],
        bonusPoints: badgeResult?.totalBonusPoints ?? 0,
      ));
    } catch (e, stackTrace) {
      return Result.failure('积分操作失败', stackTrace: stackTrace);
    }
  }
}

/// 积分操作结果（扩展）
class ApplyRuleResult {
  final bool success;
  final List<BadgeEntity> awardedBadges;  // 新增
  final int bonusPoints;                   // 新增
  const ApplyRuleResult({...});
  bool get hasBadges => awardedBadges.isNotEmpty;
}
```

### 6.3 修改 ExchangeRewardUseCase（兑换）

```dart
// lib/features/exchange/domain/usecases/exchange_reward_usecase.dart（修改后）

class ExchangeRewardUseCase extends UseCase<ExchangeRewardParams, ExchangeResult> {
  final IExchangeRepository _exchangeRepository;
  final CheckAndAwardBadgesUseCase _checkBadgesUseCase;  // 新增依赖

  @override
  Future<Result<ExchangeResult>> execute(ExchangeRewardParams params) async {
    try {
      // 1. 执行兑换（现有逻辑）
      await _exchangeRepository.exchangeReward(...);

      // 2. 新增：触发徽章检测
      final checkResult = await _checkBadgesUseCase.execute(
        CheckAndAwardBadgesParams(
          childId: params.childId,
          triggerPoint: BadgeTriggerPoint.afterExchangeCompleted,
        ),
      );

      return Result.success(ExchangeResult(
        success: true,
        awardedBadges: checkResult.dataOrNull?.awardedBadges ?? [],
        bonusPoints: checkResult.dataOrNull?.totalBonusPoints ?? 0,
      ));
    } catch (e) {
      return Result.failure('兑换失败');
    }
  }
}
```

---

## 七、Provider 注册

```dart
// lib/features/badges/providers/badge_providers.dart

/// 徽章仓库 Provider
final badgeRepositoryProvider = Provider<BadgeRepository>((ref) {
  return BadgeRepository(ref.watch(databaseProvider));
});

/// 徽章获得记录仓库 Provider
final badgeAcquisitionRepositoryProvider = Provider<BadgeAcquisitionRepository>((ref) {
  return BadgeAcquisitionRepository(ref.watch(databaseProvider));
});

/// 评估器工厂 Provider
final badgeEvaluatorFactoryProvider = Provider<BadgeEvaluatorFactory>((ref) {
  final factory = BadgeEvaluatorFactory();
  factory.register(TotalPointsEvaluator(ref.watch(pointRecordsRepositoryProvider)));
  factory.register(ConsecutiveCheckinEvaluator(ref.watch(checkinRepositoryProvider)));
  factory.register(ExchangeCountEvaluator(ref.watch(exchangeRepositoryProvider)));
  factory.register(SinglePointsEvaluator());
  return factory;
});

/// 徽章检测服务 Provider
final badgeDetectionServiceProvider = Provider<BadgeDetectionService>((ref) {
  return BadgeDetectionService(
    ref.watch(badgeRepositoryProvider),
    ref.watch(badgeAcquisitionRepositoryProvider),
    ref.watch(badgeEvaluatorFactoryProvider),
  );
});

/// 检测并授予徽章用例 Provider
final checkAndAwardBadgesUseCaseProvider = Provider<CheckAndAwardBadgesUseCase>((ref) {
  return CheckAndAwardBadgesUseCase(
    ref.watch(badgeDetectionServiceProvider),
    ref.watch(awardBadgeUseCaseProvider),
  );
});

/// 孩子徽章列表 Provider
final childBadgesProvider = FutureProvider.family<List<ChildBadgeDisplay>, int>((ref, childId) async {
  final useCase = ref.watch(getChildBadgesUseCaseProvider);
  final result = await useCase.execute(GetChildBadgesParams(childId: childId));
  return result.dataOrNull ?? [];
});

/// 孩子已获得徽章 Provider
final childAcquiredBadgesProvider = FutureProvider.family<List<ChildBadgeDisplay>, int>((ref, childId) async {
  final useCase = ref.watch(getChildBadgesUseCaseProvider);
  final result = await useCase.execute(GetChildBadgesParams(
    childId: childId,
    acquiredOnly: true,
  ));
  return result.dataOrNull ?? [];
});
```

---

## 八、目录结构

```
lib/features/badges/
├── data/
│   ├── badge_repository.dart              # 徽章定义仓库实现
│   ├── badge_acquisition_repository.dart  # 徽章获得记录仓库实现
│   └── checkin_repository.dart            # 签到记录仓库实现
├── domain/
│   ├── entities/
│   │   ├── badge_entity.dart              # 徽章实体
│   │   ├── badge_acquisition_entity.dart  # 徽章获得记录实体
│   │   └── checkin_entity.dart            # 签到记录实体
│   ├── repositories/
│   │   ├── i_badge_repository.dart        # 徽章仓库接口
│   │   ├── i_badge_acquisition_repository.dart  # 获得记录仓库接口
│   │   └── i_checkin_repository.dart      # 签到仓库接口
│   ├── evaluators/
│   │   ├── badge_condition_evaluator.dart     # 评估器接口
│   │   ├── badge_evaluator_factory.dart       # 评估器工厂
│   │   ├── total_points_evaluator.dart        # 累计积分评估器
│   │   ├── consecutive_checkin_evaluator.dart # 连续签到评估器
│   │   ├── exchange_count_evaluator.dart      # 兑换次数评估器
│   │   └── single_points_evaluator.dart       # 单次积分评估器
│   ├── services/
│   │   ├── badge_detection_service.dart   # 徽章检测服务
│   │   └── badge_trigger_points.dart      # 触发点枚举
│   └── usecases/
│       ├── check_and_award_badges_usecase.dart  # 检测并授予徽章
│       ├── award_badge_usecase.dart             # 授予徽章
│       ├── get_child_badges_usecase.dart        # 获取孩子徽章
│       ├── get_badge_progress_usecase.dart      # 获取徽章进度
│       ├── create_badge_usecase.dart            # 创建徽章
│       ├── update_badge_usecase.dart            # 更新徽章
│       ├── delete_badge_usecase.dart            # 删除徽章
│       └── checkin_usecase.dart                 # 签到用例
├── presentation/
│   ├── screens/
│   │   ├── badge_gallery_screen.dart      # 徽章展示页
│   │   ├── badge_detail_screen.dart       # 徽章详情页
│   │   └── badge_manage_screen.dart       # 徽章管理页
│   └── widgets/
│       ├── badge_card.dart                # 徽章卡片组件
│       ├── badge_grid.dart                # 徽章网格组件
│       ├── badge_progress_indicator.dart  # 进度指示器
│       └── badge_award_dialog.dart        # 获得徽章弹窗
└── providers/
    └── badge_providers.dart               # Riverpod Providers
```

---

## 九、预置系统徽章

| 徽章名称 | 类型 | 阈值 | 奖励积分 | 等级 | 图标 |
|----------|------|------|----------|------|------|
| 初露锋芒 | 累计积分 | 100 | 10 | 1 | badge_bronze_star |
| 小有成就 | 累计积分 | 500 | 30 | 2 | badge_silver_star |
| 星光璀璨 | 累计积分 | 1000 | 50 | 3 | badge_gold_star |
| 满天星斗 | 累计积分 | 5000 | 100 | 4 | badge_diamond_star |
| 坚持一周 | 连续签到 | 7 | 20 | 1 | badge_calendar_week |
| 坚持一月 | 连续签到 | 30 | 50 | 2 | badge_calendar_month |
| 习惯养成 | 连续签到 | 100 | 100 | 3 | badge_calendar_hundred |
| 初次尝鲜 | 兑换次数 | 1 | 5 | 1 | badge_gift_first |
| 购物达人 | 兑换次数 | 10 | 30 | 2 | badge_gift_master |
| 大有作为 | 单次积分 | 50 | 20 | 1 | badge_lightning |

---

## 十、UI 设计要点

### 10.1 徽章展示位置
- **孩子档案页**：已获得徽章网格展示
- **设置页**：徽章管理入口
- **获得时**：弹窗动画通知 + 奖励积分展示

### 10.2 徽章卡片状态
- **已获得**：彩色图标 + 获得时间 + 奖励积分
- **未获得**：灰色图标 + 进度条 + 解锁条件
- **锁定**：显示解锁条件描述

### 10.3 获得弹窗设计
```
┌────────────────────────────────┐
│                                │
│         🏆 恭喜获得徽章!        │
│                                │
│        ⭐ 星光璀璨 ⭐           │
│     累计获得 1000 颗星星        │
│                                │
│      🎁 奖励: +50 星星          │
│                                │
│         [ 太棒了! ]            │
│                                │
└────────────────────────────────┘
```

---

## 十一、实施计划

| 阶段 | 内容 | 优先级 | 预估工作量 |
|------|------|--------|-----------|
| **Phase 1** | 数据库表 + 实体定义 + 仓库层 | P0 | 1天 |
| **Phase 2** | 评估器引擎 + 检测服务 | P0 | 1天 |
| **Phase 3** | 用例实现 + Provider 注册 | P0 | 1天 |
| **Phase 4** | 集成现有模块（积分/兑换） | P0 | 0.5天 |
| **Phase 5** | UI 页面（展示/弹窗） | P1 | 1.5天 |
| **Phase 6** | 签到功能 + 连续签到徽章 | P2 | 1天 |
| **Phase 7** | 徽章管理页（自定义徽章） | P2 | 1天 |

---

## 十二、设计优势总结

| 设计点 | 方案 | 优势 |
|--------|------|------|
| 触发条件 | 策略模式 + 枚举 + JSON扩展 | 类型安全，易于扩展新条件类型 |
| 检测时机 | 事件驱动（后置触发） | 与业务解耦，不阻塞主流程 |
| 条件评估 | 评估器工厂 | 开闭原则，新增类型无需修改核心代码 |
| 数据快照 | 获得记录存储徽章快照 | 历史数据不受徽章修改影响 |
| 积分奖励 | 复用现有积分流水 | 统一积分管理，保证数据一致性 |

---

## 十三、扩展性预留

1. **新增触发类型**：只需实现 `IBadgeConditionEvaluator` 接口并注册到工厂
2. **复杂条件**：`triggerConfig` JSON 字段支持任意复杂配置
3. **自定义徽章**：`isSystem=false` 支持用户自定义徽章
4. **徽章等级**：`level` 字段支持同系列徽章的递进展示
5. **多条件组合**：可扩展为 `AND/OR` 组合条件（通过 custom 类型实现）

---

## 十四、注意事项

1. **性能考虑**：徽章检测应在主事务外异步执行，避免影响主业务响应时间
2. **幂等性**：已获得徽章不会重复授予（通过 `acquiredBadgeIds` 集合检查）
3. **软删除**：所有删除操作都是软删除，保护历史数据完整性
4. **快照存储**：获得记录存储徽章快照，防止修改后丢失上下文
5. **国际化**：徽章名称和描述需要支持多语言（通过 l10n 处理）

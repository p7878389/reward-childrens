import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'tables.dart';
import 'connection/connection.dart' as impl;

part 'app_database.g.dart';

@DriftDatabase(tables: [Children, Rules, PointRecords, Rewards, Exchanges, AppContents, AppLogs, Badges, BadgeAcquisitions, CheckinRecords])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _seedSystemRules();
        await _seedAppContents();
        await _seedSystemBadges();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(badges);
          await m.createTable(badgeAcquisitions);
          await m.createTable(checkinRecords);
          await _seedSystemBadges();
        }
      },
    );
  }

  /// 初始化系统徽章
  Future<void> _seedSystemBadges() async {
    final existing = await (select(badges)..where((t) => t.isSystem.equals(true))).get();
    if (existing.isEmpty) {
      final now = DateTime.now();
      final systemBadges = [
        // 累计积分
        _buildBadgeCompanion('初露锋芒', '累计获得 100 颗星星', 'badge_bronze_star', 1, 'total_points', 100, 10, 1, now),
        _buildBadgeCompanion('小有成就', '累计获得 500 颗星星', 'badge_silver_star', 2, 'total_points', 500, 30, 2, now),
        _buildBadgeCompanion('星光璀璨', '累计获得 1000 颗星星', 'badge_gold_star', 3, 'total_points', 1000, 50, 3, now),
        _buildBadgeCompanion('满天星斗', '累计获得 5000 颗星星', 'badge_diamond_star', 4, 'total_points', 5000, 100, 4, now),
        // 连续签到
        _buildBadgeCompanion('坚持一周', '连续签到 7 天', 'badge_calendar_week', 1, 'consecutive_checkin', 7, 20, 5, now),
        _buildBadgeCompanion('坚持一月', '连续签到 30 天', 'badge_calendar_month', 2, 'consecutive_checkin', 30, 50, 6, now),
        _buildBadgeCompanion('习惯养成', '连续签到 100 天', 'badge_calendar_hundred', 3, 'consecutive_checkin', 100, 100, 7, now),
        // 兑换次数
        _buildBadgeCompanion('初次尝鲜', '兑换 1 次商品', 'badge_gift_first', 1, 'exchange_count', 1, 5, 8, now),
        _buildBadgeCompanion('购物达人', '兑换 10 次商品', 'badge_gift_master', 2, 'exchange_count', 10, 30, 9, now),
        // 单次积分
        _buildBadgeCompanion('大有作为', '单次获得 50 颗星星', 'badge_lightning', 1, 'points_earned_single', 50, 20, 10, now),
      ];

      await batch((b) {
        b.insertAll(badges, systemBadges);
      });
    }
  }

  BadgesCompanion _buildBadgeCompanion(
    String name,
    String description,
    String icon,
    int level,
    String type,
    int threshold,
    int bonus,
    int sort,
    DateTime now,
  ) {
    return BadgesCompanion.insert(
      name: name,
      description: Value(description),
      icon: icon,
      level: Value(level),
      triggerType: type,
      triggerThreshold: threshold,
      bonusPoints: Value(bonus),
      sortOrder: Value(sort),
      isSystem: const Value(true),
      createdAt: now,
    );
  }

  Future<void> _seedSystemRules() async {
    final existing = await (select(rules)..where((t) => t.isSystem.equals(true))).get();
    if (existing.isEmpty) {
      try {
        final sqlContent = await rootBundle.loadString('assets/sql/rules.sql');
        final statements = sqlContent
            .split(';')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty);

        await batch((batch) {
          for (final statement in statements) {
            batch.customStatement(statement);
          }
        });
      } catch (e) {
        // Fallback or log error (e.g. if asset not found during testing)
        print('Error seeding system rules from SQL: $e');

        // Fallback to minimal defaults if SQL fails
        await into(rules).insert(RulesCompanion.insert(
          name: 'Custom Reward',
          icon: const Value('star'),
          points: 1,
          type: const Value('reward'),
          isSystem: const Value(true),
          createdAt: DateTime.now(),
        ));
      }
    }
  }

  /// 清空所有用户数据（保留系统规则）
  Future<void> clearAllData() async {
    await transaction(() async {
      // 1. 删除所有积分记录
      await delete(pointRecords).go();
      // 2. 删除所有兑换记录
      await delete(exchanges).go();
      // 3. 删除所有宝贝档案
      await delete(children).go();
      // 4. 删除所有商品
      await delete(rewards).go();
      // 5. 删除用户自定义规则（保留系统规则）
      await (delete(rules)..where((t) => t.isSystem.equals(false))).go();
    });
  }

  /// 初始化应用内容（隐私协议等）
  Future<void> _seedAppContents() async {
    final existing = await (select(appContents)..where((t) => t.key.equals('privacy_policy'))).get();
    if (existing.isEmpty) {
      await into(appContents).insert(AppContentsCompanion.insert(
        key: 'privacy_policy',
        titleEn: 'Privacy Policy',
        titleZh: '隐私协议',
        contentEn: '''
# Privacy Policy

**Last Updated: December 2024**

## 1. Introduction

Welcome to Children Rewards ("we," "our," or "us"). We are committed to protecting your privacy and the privacy of your children. This Privacy Policy explains how we collect, use, and safeguard information when you use our mobile application.

## 2. Information We Collect

### 2.1 Information You Provide
- **Child Profiles**: Names, avatars, birthdays (optional), and gender of children you add to the app
- **Rewards and Rules**: Custom rewards, point rules, and activity records you create
- **Usage Data**: Points earned, spent, and reward redemption history

### 2.2 Information Stored Locally
All data is stored **locally on your device only**. We do not collect, transmit, or store any personal information on external servers.

## 3. How We Use Information

The information you provide is used solely to:
- Track and manage your children's reward points
- Display achievement history and statistics
- Provide a personalized experience within the app

## 4. Data Security

- All data is stored locally on your device using encrypted SQLite database
- We do not have access to any of your data
- Data is protected by your device's security measures

## 5. Data Sharing

We do **NOT**:
- Share your data with third parties
- Sell your personal information
- Use your data for advertising purposes
- Transmit any data over the internet

## 6. Children's Privacy

This app is designed for family use. We take children's privacy seriously:
- No personal data is collected from children
- No online features or external communications
- Parents have full control over all data

## 7. Data Retention and Deletion

- Data remains on your device until you delete it
- You can clear all data anytime via Settings > Clear All Data
- Uninstalling the app removes all stored data

## 8. Your Rights

You have complete control over your data:
- View all stored information within the app
- Edit or delete any profiles, rules, or rewards
- Export or backup data through device backup systems
- Delete all data at any time

## 9. Changes to This Policy

We may update this Privacy Policy from time to time. We will notify you of any changes by updating the "Last Updated" date.

## 10. Contact Us

If you have questions about this Privacy Policy, please contact us at:
- Email: support@childrenrewards.app

---

*This app respects your privacy. All data stays on your device.*
''',
        contentZh: '''
# 隐私协议

**最后更新：2024年12月**

## 1. 简介

欢迎使用儿童积分奖励（以下简称"我们"）。我们致力于保护您和您宝贝的隐私。本隐私协议说明了当您使用我们的移动应用程序时，我们如何收集、使用和保护信息。

## 2. 我们收集的信息

### 2.1 您提供的信息
- **宝贝档案**：您添加到应用中的宝贝姓名、头像、生日（可选）和性别
- **奖励和规则**：您创建的自定义奖励、积分规则和活动记录
- **使用数据**：积分获取、消费和奖励兑换历史

### 2.2 本地存储的信息
所有数据**仅存储在您的设备本地**。我们不会在外部服务器上收集、传输或存储任何个人信息。

## 3. 我们如何使用信息

您提供的信息仅用于：
- 追踪和管理您宝贝的奖励积分
- 显示成就历史和统计数据
- 在应用内提供个性化体验

## 4. 数据安全

- 所有数据使用加密的 SQLite 数据库存储在您的设备本地
- 我们无法访问您的任何数据
- 数据受您设备安全措施的保护

## 5. 数据共享

我们**不会**：
- 与第三方共享您的数据
- 出售您的个人信息
- 将您的数据用于广告目的
- 通过互联网传输任何数据

## 6. 儿童隐私

本应用专为家庭使用设计。我们非常重视儿童隐私：
- 不收集儿童的个人数据
- 无在线功能或外部通信
- 家长对所有数据拥有完全控制权

## 7. 数据保留和删除

- 数据保留在您的设备上，直到您删除它
- 您可以随时通过设置 > 清空所有数据来清除所有数据
- 卸载应用将删除所有存储的数据

## 8. 您的权利

您对您的数据拥有完全控制权：
- 在应用内查看所有存储的信息
- 编辑或删除任何档案、规则或奖励
- 通过设备备份系统导出或备份数据
- 随时删除所有数据

## 9. 本协议的变更

我们可能会不时更新本隐私协议。我们将通过更新"最后更新"日期来通知您任何变更。

## 10. 联系我们

如果您对本隐私协议有任何疑问，请通过以下方式联系我们：
- 电子邮件：support@childrenrewards.app

---

*本应用尊重您的隐私。所有数据都保存在您的设备上。*
''',
        createdAt: DateTime.now(),
      ));
    }
  }

  /// 根据 key 获取应用内容
  Future<AppContent?> getAppContent(String key) async {
    return (select(appContents)..where((t) => t.key.equals(key))).getSingleOrNull();
  }

  // ==================== 日志相关方法 ====================

  /// 批量插入日志（供异步日志器使用）
  Future<void> insertLogsBatch(List<AppLogsCompanion> logs) async {
    await batch((b) {
      b.insertAll(appLogs, logs);
    });
  }

  /// 查询日志（支持分页和过滤）
  Future<List<AppLog>> queryLogs({
    String? level,
    String? tag,
    DateTime? startTime,
    DateTime? endTime,
    int limit = 100,
    int offset = 0,
  }) async {
    final query = select(appLogs)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(limit, offset: offset);

    if (level != null) {
      query.where((t) => t.level.equals(level));
    }
    if (tag != null) {
      query.where((t) => t.tag.equals(tag));
    }
    if (startTime != null) {
      query.where((t) => t.createdAt.isBiggerOrEqualValue(startTime));
    }
    if (endTime != null) {
      query.where((t) => t.createdAt.isSmallerOrEqualValue(endTime));
    }

    return query.get();
  }

  /// 获取日志总数
  Future<int> getLogsCount({String? level, String? tag}) async {
    final query = selectOnly(appLogs)..addColumns([appLogs.id.count()]);
    if (level != null) {
      query.where(appLogs.level.equals(level));
    }
    if (tag != null) {
      query.where(appLogs.tag.equals(tag));
    }
    final result = await query.getSingle();
    return result.read(appLogs.id.count()) ?? 0;
  }

  /// 清空所有日志
  Future<void> clearAllLogs() async {
    await delete(appLogs).go();
  }

  /// 清理过期日志（保留指定天数内的日志）
  Future<int> cleanOldLogs({int keepDays = 7}) async {
    final cutoffDate = DateTime.now().subtract(Duration(days: keepDays));
    return (delete(appLogs)..where((t) => t.createdAt.isSmallerThanValue(cutoffDate))).go();
  }

  /// 获取所有不同的标签（用于过滤）
  Future<List<String>> getDistinctTags() async {
    final query = selectOnly(appLogs, distinct: true)..addColumns([appLogs.tag]);
    final results = await query.get();
    return results.map((row) => row.read(appLogs.tag)!).toList();
  }
}

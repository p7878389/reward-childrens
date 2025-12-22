# 架构优化任务清单

> 基于架构审查报告，制定的详细优化任务清单
>
> 创建时间：2024-12-20
>
> 状态说明：⬜ 待处理 | 🔄 进行中 | ✅ 已完成 | ⏸️ 暂停

---

## 📊 总体进度

| 阶段 | 任务数 | 完成数 | 进度 |
|------|--------|--------|------|
| 第一阶段：短期改进 | 8 | 8 | 100% |
| 第二阶段：中期改进 | 4 | 4 | 100% |
| 第三阶段：长期规划 | 3 | 1 | 33% |
| **总计** | **15** | **13** | **87%** |

---

## 🚀 第一阶段：短期改进（低成本高收益）

### 1.1 统一 Provider 定义位置

#### 任务 1.1.1：重构 points 模块 Provider ✅

**当前问题**：Provider 混合定义在 `data/` 目录的 Repository 文件中

**涉及文件**：
- `lib/features/points/data/rules_repository.dart`
- `lib/features/points/data/point_records_repository.dart`

**执行步骤**：
1. 创建 `lib/features/points/providers/` 目录
2. 创建 `lib/features/points/providers/rules_providers.dart`
   - 移入 `rulesRepositoryProvider`
   - 移入 `rulesStreamProvider`
   - 移入 `RulesPaginationNotifier` 类
   - 移入 `rulesPaginationProvider`
3. 创建 `lib/features/points/providers/point_records_providers.dart`
   - 移入 `pointRecordsRepositoryProvider`
   - 移入 `pointRecordsStreamProvider`
   - 移入 `pointStatsFutureProvider`
   - 移入 `PointRecordsPaginationNotifier` 类
   - 移入 `pointRecordsPaginationProvider`
4. 更新所有导入路径
5. 编译验证

**预期结果**：
```
features/points/
├── providers/                    # 新建
│   ├── rules_providers.dart      # 新建
│   └── point_records_providers.dart  # 新建
├── data/
│   ├── rules_repository.dart     # 仅保留 RulesRepository 类
│   └── point_records_repository.dart  # 仅保留 PointRecordsRepository 类
└── presentation/
```

---

#### 任务 1.1.2：重构 rewards 模块 Provider ✅

**当前问题**：
- Provider 混合在 `data/` 目录
- `rewardsStorePaginationProvider` 定义在 Screen 文件中（违反分层原则）

**涉及文件**：
- `lib/features/rewards/data/rewards_repository.dart`
- `lib/features/rewards/data/exchange_repository.dart`
- `lib/features/rewards/presentation/screens/rewards_store_screen.dart`

**执行步骤**：
1. 创建 `lib/features/rewards/providers/` 目录
2. 创建 `lib/features/rewards/providers/rewards_providers.dart`
   - 移入 `rewardsRepositoryProvider`
   - 移入 `rewardsStreamProvider`
   - 移入 `RewardsPaginationNotifier` 类
   - 移入 `rewardsPaginationProvider`
   - 移入 `rewardsStorePaginationProvider`（从 Screen 移出）
3. 创建 `lib/features/rewards/providers/exchange_providers.dart`
   - 移入 `exchangeRepositoryProvider`
   - 移入 `exchangesStreamProvider`
   - 移入 `ExchangesPaginationNotifier` 类
   - 移入 `exchangesPaginationProvider`
4. 更新所有导入路径
5. 编译验证

**预期结果**：
```
features/rewards/
├── providers/                    # 新建
│   ├── rewards_providers.dart    # 新建
│   └── exchange_providers.dart   # 新建
├── data/
│   ├── rewards_repository.dart   # 仅保留 Repository 类
│   └── exchange_repository.dart  # 仅保留 Repository 类
└── presentation/
```

---

### 1.2 提取共享 Widget

#### 任务 1.2.1：提取 HeaderIconButton Widget ✅

**当前问题**：`_buildHeaderBtn()` 方法在多个 Screen 重复定义

**重复位置**：
- `lib/features/children/presentation/screens/home_screen.dart`
- `lib/features/points/presentation/screens/points_history_screen.dart`
- `lib/features/rewards/presentation/screens/rewards_store_screen.dart`

**执行步骤**：
1. 创建 `lib/shared/widgets/header_icon_button.dart`
2. 实现 `HeaderIconButton` Widget：
   ```dart
   class HeaderIconButton extends StatelessWidget {
     final IconData icon;
     final VoidCallback? onTap;
     final double size;
     final Color? backgroundColor;
     final Color? iconColor;

     const HeaderIconButton({
       super.key,
       required this.icon,
       this.onTap,
       this.size = 40,
       this.backgroundColor,
       this.iconColor,
     });

     @override
     Widget build(BuildContext context) { ... }
   }
   ```
3. 替换 `home_screen.dart` 中的 `_buildHeaderBtn`
4. 替换 `points_history_screen.dart` 中的 `_buildHeaderBtn`
5. 替换 `rewards_store_screen.dart` 中的 `_buildHeaderBtn`
6. 删除各文件中的重复方法
7. 编译验证

---

#### 任务 1.2.2：提取 AvatarImage Widget ✅

**当前问题**：头像显示逻辑在多处重复

**执行步骤**：
1. 创建 `lib/shared/widgets/avatar_image.dart`
2. 实现 `AvatarImage` Widget：
   ```dart
   class AvatarImage extends StatelessWidget {
     final String? imagePath;
     final double size;
     final String? fallbackAsset;
     final BoxFit fit;

     const AvatarImage({
       super.key,
       this.imagePath,
       this.size = 48,
       this.fallbackAsset,
       this.fit = BoxFit.cover,
     });

     @override
     Widget build(BuildContext context) {
       // 统一处理：本地路径 / Asset / 默认头像
     }
   }
   ```
3. 替换各处的头像显示逻辑
4. 编译验证

---

### 1.3 合并重复逻辑

#### 任务 1.3.1：合并兑换逻辑 ✅

**当前问题**：两个方法实现相似但不同的兑换逻辑
- `RewardsRepository.redeemReward()` - 简单版本，无校验
- `ExchangeRepository.exchangeReward()` - 完整版本，有校验

**涉及文件**：
- `lib/features/rewards/data/rewards_repository.dart`
- `lib/features/rewards/data/exchange_repository.dart`

**执行步骤**：
1. 检查 `redeemReward()` 的调用位置
2. 将所有调用替换为 `exchangeReward()`
3. 删除 `RewardsRepository.redeemReward()` 方法
4. 确保 `exchangeReward()` 包含完整的业务校验：
   - 奖励是否激活
   - 积分是否充足
   - 库存是否充足
5. 编译验证
6. 测试兑换功能

---

### 1.4 统一删除策略

#### 任务 1.4.1：Rules 表改为软删除 ✅

**当前问题**：
- `Children` 表使用软删除 (`isDeleted` 字段)
- `Rules` 表使用硬删除 (直接 DELETE)

**涉及文件**：
- `lib/core/database/tables.dart`
- `lib/features/points/data/rules_repository.dart`

**执行步骤**：
1. 修改 `Rules` 表定义，添加 `isDeleted` 字段
2. 创建数据库迁移脚本（升级到 version 7）
3. 修改 `RulesRepository.deleteRule()` 方法：
   ```dart
   Future<void> deleteRule(int id) {
     return (_db.update(_db.rules)..where((t) => t.id.equals(id)))
       .write(RulesCompanion(
         isDeleted: const Value(true),
         updatedAt: Value(DateTime.now()),
       ));
   }
   ```
4. 修改所有查询方法，过滤 `isDeleted = false`
5. 编译验证

---

#### 任务 1.4.2：Rewards 表改为软删除 ✅

**涉及文件**：
- `lib/core/database/tables.dart`
- `lib/features/rewards/data/rewards_repository.dart`

**执行步骤**：
1. 检查 `Rewards` 表是否有 `isDeleted` 字段
2. 如无，添加字段并创建迁移
3. 修改 `deleteReward()` 方法为软删除
4. 修改查询方法过滤已删除记录
5. 编译验证

---

### 1.5 修复日志系统

#### 任务 1.5.1：统一 LogLevel 枚举定义 ✅

**当前问题**：LogLevel 在两处定义且不一致

**涉及文件**：
- `lib/core/logging/log_level.dart`
- `lib/core/services/logger_service.dart`

**执行步骤**：
1. 确定统一的 LogLevel 定义：
   ```dart
   enum LogLevel { debug, info, warning, error }
   ```
2. 删除 `logger_service.dart` 中的重复定义
3. 统一导入 `core/logging/log_level.dart`
4. 如需 `none` 级别，在统一位置添加
5. 编译验证

---

## 🔧 第二阶段：中期改进（中等成本）

### 2.1 引入 Repository 接口

#### 任务 2.1.1：创建 ChildrenRepository 接口 ✅

**目的**：解耦具体实现，支持 Mock 测试

**已完成**：
- 创建 `lib/features/children/domain/repositories/i_children_repository.dart`
- 修改 `ChildrenRepository` 实现接口
- 添加 `@override` 注解

---

#### 任务 2.1.2：创建其他 Repository 接口 ✅

**已完成的接口**：
- `IRulesRepository` → `lib/features/points/domain/repositories/i_rules_repository.dart`
- `IPointRecordsRepository` → `lib/features/points/domain/repositories/i_point_records_repository.dart`
- `IRewardsRepository` → `lib/features/rewards/domain/repositories/i_rewards_repository.dart`
- `IExchangeRepository` → `lib/features/rewards/domain/repositories/i_exchange_repository.dart`

---

### 2.2 引入 Domain Entity

#### 任务 2.2.1：创建 Child Entity ✅

**已完成**：
- 创建 `lib/features/children/domain/entities/child_entity.dart`
- 包含 `Gender` 枚举
- 包含业务方法：`hasEnoughStars()`, `isActive`, `withStars()`, `copyWith()`

---

#### 任务 2.2.2：创建其他 Domain Entity ✅

**已完成的实体**：
- `RuleEntity` → `lib/features/points/domain/entities/rule_entity.dart`
- `PointRecordEntity` → `lib/features/points/domain/entities/point_record_entity.dart`
- `RewardEntity` → `lib/features/rewards/domain/entities/reward_entity.dart`
- `ExchangeEntity` → `lib/features/rewards/domain/entities/exchange_entity.dart`

---

## 🏗️ 第三阶段：长期规划（战略性）

### 3.1 完整 Domain 层

#### 任务 3.1.1：引入 UseCase 模式 ✅

**目的**：业务逻辑集中，单一职责

**已完成**：

1. **核心基础设施**：
   - `lib/core/usecases/result.dart` - Result 类型（Success/Failure 封装）
   - `lib/core/usecases/usecase.dart` - UseCase 基类
   - `lib/core/usecases/usecases.dart` - 导出文件

2. **Children 模块 UseCases**：
   - `CreateChildUseCase` - 创建宝贝
   - `UpdateChildUseCase` - 更新宝贝
   - `DeleteChildUseCase` - 删除宝贝

3. **Points 模块 UseCases**：
   - `ApplyRuleUseCase` - 应用规则（加分/扣分）

4. **Rewards 模块 UseCases**：
   - `ExchangeRewardUseCase` - 兑换奖励

5. **Provider 集成**：
   - 各模块 Provider 文件已添加 UseCase Provider
   - `createChildUseCaseProvider`
   - `updateChildUseCaseProvider`
   - `deleteChildUseCaseProvider`
   - `applyRuleUseCaseProvider`
   - `exchangeRewardUseCaseProvider`

---

### 3.2 路由管理

#### 任务 3.2.1：引入 go_router ⬜

**目的**：统一路由管理，支持深链接

**执行步骤**：
1. 添加 `go_router` 依赖
2. 创建 `lib/app/router/app_router.dart`
3. 定义所有路由配置
4. 替换现有的 `Navigator.push` 调用

---

### 3.3 测试架构

#### 任务 3.3.1：建立单元测试框架 ⬜

**目的**：保证代码质量，支持重构

**执行步骤**：
1. 添加测试依赖 (mockito, etc.)
2. 为 UseCase 编写单元测试
3. 为 Repository 编写集成测试
4. 配置 CI 测试流程

---

## 📝 变更日志

| 日期 | 任务 | 状态 | 备注 |
|------|------|------|------|
| 2024-12-20 | 创建任务清单 | ✅ | 基于架构审查报告 |
| 2024-12-20 | 任务 1.1.1 | ✅ | 重构 points 模块 Provider |
| 2024-12-20 | 任务 1.1.2 | ✅ | 重构 rewards 模块 Provider |
| 2024-12-20 | 任务 1.2.1 | ✅ | 提取 HeaderButton Widget |
| 2024-12-20 | 任务 1.2.2 | ✅ | 创建 AvatarImage Widget |
| 2024-12-20 | 任务 1.3.1 | ✅ | 合并兑换逻辑到 exchangeReward |
| 2024-12-20 | 任务 1.4.1 | ✅ | Rules 表改为软删除 |
| 2024-12-20 | 任务 1.4.2 | ✅ | Rewards 表已使用软删除（验证） |
| 2024-12-20 | 任务 1.5.1 | ✅ | 统一 LogLevel 枚举定义 |
| 2024-12-20 | 任务 2.1.1 | ✅ | 创建 IChildrenRepository 接口 |
| 2024-12-20 | 任务 2.1.2 | ✅ | 创建其他 Repository 接口 |
| 2024-12-20 | 任务 2.2.1 | ✅ | 创建 ChildEntity |
| 2024-12-20 | 任务 2.2.2 | ✅ | 创建其他 Domain Entity |
| 2024-12-20 | 任务 3.1.1 | ✅ | 引入 UseCase 模式 |

---

## 📎 相关文档

- [架构审查报告](./comprehensive_review_report.md)
- [数据库设计文档](./database_design.md)
- [需求文档](./requirements.md)

# 成语游戏扩展功能技术方案

> 创建日期: 2025-12-26
> 更新日期: 2025-12-26 (Architect Reviewed)
> 状态: 设计中

## 一、功能概述

| 模式 | 玩法 | 交互方式 |
|------|------|----------|
| **成语补全** | 显示部分字，玩家补全完整成语 | 语音输入 / **选字填空** (Word Bank) |
| **看意思猜成语** | 显示释义，从4个选项中选择 | 点击选择 |

---

## 二、数据层设计

### 2.1 复用现有数据

现有 `Idioms` 表已包含所需字段：
- `word` - 成语文字
- `explanation` - 释义（用于"看意思猜成语"）
- `pinyin` - 拼音（用于提示）
- `gradeLevel` - 难度分级

### 2.2 新增游戏记录表

```dart
// tables.dart 新增
class IdiomPuzzleRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get childId => integer().references(Childrens, #id)();
  TextColumn get gameMode => text()();  // 'completion' | 'meaning'
  IntColumn get grade => integer()();
  IntColumn get correctCount => integer()();
  IntColumn get totalCount => integer()();
  IntColumn get starsEarned => integer()();
  IntColumn get timeTakenSeconds => integer()();
  DateTimeColumn get playedAt => dateTime()();
}
```

### 2.3 DAO 新增方法

```dart
// idiom_dao.dart 扩展
abstract class IdiomDao {
  // 获取有释义的成语（用于"看意思猜成语"）
  // 必须过滤 explanation 为空或过短的数据
  Future<List<Idiom>> getIdiomsWithExplanation(int grade, int limit);

  // 获取所有符合年级的成语ID列表（用于高性能随机抽取）
  Future<List<int>> getIdiomIdsByGrade(int grade);
  
  // 根据ID列表批量获取成语
  Future<List<Idiom>> getIdiomsByIds(List<int> ids);

  // 统计某年级可用成语数量 (Health Check)
  Future<int> countAvailableIdioms(int grade, {bool requireExplanation = false});
}
```

---

## 三、业务逻辑层设计

### 3.1 游戏模式枚举

```dart
// idiom_game_entities.dart 扩展
enum IdiomGameMode {
  chain,      // 现有：成语接龙
  completion, // 新增：成语补全
  meaning,    // 新增：看意思猜成语
}
```

### 3.2 成语补全 - 复用现有配置

**隐藏字数映射**：复用 `GameConfig.difficulty`

```dart
extension DifficultyExtension on Difficulty {
  int get hiddenCharCount => switch (this) {
    Difficulty.easy => 1,    // 隐藏1字
    Difficulty.normal => 2,  // 隐藏2字
    Difficulty.hard => 3,    // 隐藏3字
  };
}
```

### 3.3 实体定义

```dart
// idiom_puzzle_entities.dart

/// 成语补全题目
class CompletionPuzzle {
  final Idiom idiom;
  final String maskedWord;       // "一__当__"
  final List<int> hiddenIndices; // [1, 3]
  final List<String> wordBank;   // 备选字库 (正确字 + 干扰字)，用于选字模式
}

/// 看意思猜成语题目（选择题）
class MeaningPuzzle {
  final Idiom correctIdiom;
  final String explanation;
  final List<String> options;    // 4个选项
  final int correctIndex;        // 正确答案索引
}

/// 答题结果
class PuzzleResult {
  final bool isCorrect;
  final int timeTaken;
  final int? selectedIndex;      // 选择题用
  final String? playerInput;     // 补全题用
}
```

### 3.4 服务接口与架构抽象

建议引入 `GameSessionController` 抽象基类，统一管理游戏生命周期。

```dart
// core/game/game_session_controller.dart
abstract class GameSessionController<T_Puzzle, T_Result> extends StateNotifier<GameState> {
   // 统一管理：倒计时 timer, 当前题目 index, 得分 score, 星星扣除 logic
}

// idiom_puzzle_service.dart
abstract class IdiomPuzzleService {
  // ... 生成题目接口保持不变
}
```

### 3.5 核心算法优化

#### 优化策略：高性能随机算法
**避免**在 SQLite 中使用 `ORDER BY RANDOM()` 对全表排序。
**采用**: `Fetch IDs` -> `Dart Shuffle` -> `Fetch Entities`。

#### 看意思猜成语 - 选项生成算法 (Optimized)

```
输入: 正确成语 "风驰电掣" (grade=5)
步骤:
1. (预处理) 获取该年级所有成语 ID 列表: allIds = [101, 102, ..., 999]
2. 在内存中排除正确ID，并 Shuffle: allIds.shuffle()
3. 取前3个 ID 作为干扰项 ID
4. 批量查询数据库: SELECT * FROM idioms WHERE id IN (correctId, ...distractorIds)
5. 组装选项，随机打乱顺序
输出: options=["大步流星","风驰电掣","健步如飞","一日千里"]
```

#### 成语补全 - 备选字库生成 (Word Bank)

```
输入: "一马当先", hiddenIndices=[1,3] (隐藏 '马', '先')
步骤:
1. 提取正确字: ['马', '先']
2. 生成干扰字: 随机选取 6 个常用汉字 (或同音字/形近字)
3. 合并列表: size=8
4. Shuffle 列表
输出: wordBank=['牛', '马', '后', '先', '上', '下', '天', '地']
```

---

## 四、展示层设计

### 4.1 UI 设计优化

#### 成语补全界面 (`CompletionGameScreen`)

**交互修正**:
考虑到儿童输入困难，默认提供 **选字填空 (Word Bank)** 交互，语音输入作为辅助。

```
┌─────────────────────────────────┐
│  第 3/10 题        ⭐ 已获得: 5  │
├─────────────────────────────────┤
│                                 │
│         一 __ 当 __             │
│                                 │
│   [ 空格区域支持点击选中 ]       │
│                                 │
│   ┌─────────────────────────┐   │
│   │ 备选字库区域 (Word Bank) │   │
│   │ [马] [牛] [先] [后] ... │   │
│   └─────────────────────────┘   │
│                                 │
│   [🎤 语音(辅助)]    [💡 提示]   │
│                                 │
│   ⏱️ 00:45                      │
└─────────────────────────────────┘
```

#### 视觉反馈 (Visual Feedback)
引入动画库 (`flutter_animate` 或类似)：
- **答对**: 题目卡片微小 **弹跳 (Bounce)** + 绿色光晕。
- **答错**: 题目卡片 **左右晃动 (Shake)** + 红色边框。

### 4.2 组件复用

| 组件 | 说明 |
|------|------|
| `GameHeaderBar` | 封装进度条和星星计数，两个游戏页面复用 |
| `IdiomCharBox` | 封装单个汉字的显示逻辑（显示/隐藏/下划线/高亮/选中态） |
| `WordBankGrid` | **新增**: 备选字网格组件 |
| `OptionButton` | 封装选项按钮，处理 Normal/Correct/Wrong 三种视觉状态 |

---

## 五、星星计算规则

| 指标 | 规则 |
|------|------|
| 基础星星 | 正确率 60%=1⭐, 80%=2⭐, 100%=3⭐ |
| 速度奖励 | 平均答题<5秒 +1⭐ |
| 提示惩罚 | 每使用1次提示 -0.5⭐（仅补全模式） |
| 年级系数 | 3年级=1.2x, 5年级=1.5x, 7年级=2.0x |

---

## 六、技术与体验优化建议 (Optimization Details)

### 1. 数据质量与健康检查 (Health Check)
在进入游戏前（如 `PuzzleModeSelectionScreen` 加载时），必须运行健康检查：
- 检查该年级是否有足够的成语数据（例如 > 20 条）。
- 对于 "猜意思" 模式，检查 `explanation` 字段非空且长度达标的数据量。
- **Fail-safe**: 如果数据不足，禁用入口并提示 "题库升级中"。

### 2. 性能优化 (Performance)
- **ID Shuffle**: 严格执行 Dart 侧的随机算法，禁止 SQL 侧随机排序。
- **预加载 (Preloading)**: 在用户思考当前题目时，异步预加载下一题的数据（特别是 TTS 音频），实现 "零等待" 切题。

### 3. 输入交互 (Input)
- **选字填空**: 作为 Phase 1 的核心交互，替代全键盘输入。
- **容错匹配**: 在语音输入模式下，如果识别结果与答案同音（声调不同），应视为正确或给予 "读音正确" 的提示，降低挫败感。

### 4. 异常处理 (Error Handling)
- **TTS 失败兜底**: 如果 TTS 服务不可用，不应阻塞游戏流程，仅显示文本即可。
- **网络降级**: 所有核心逻辑必须支持完全离线运行。

---

## 七、开发任务分解 (Phase 1 Focus)

1.  **Core**: 实现 `IdiomPuzzleService` 及 "ID Shuffle" 算法。
2.  **State**: 实现 `GameSessionController` 基类及 `CompletionGameNotifier`。
3.  **UI**: 开发 `IdiomCharBox` 和 `WordBankGrid` 组件。
4.  **UI**: 组装 `CompletionGameScreen` 并集成 `Visual Feedback` (Shake/Bounce)。

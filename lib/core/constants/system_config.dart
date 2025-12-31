/// 系统级配置常量
library;

import 'package:flutter/foundation.dart';

/// 本地数据库文件名
const String kDatabaseFileName = 'children_rewards.db';

/// 预编译数据库资源路径（仅 Debug 使用）
const String kPrebuiltDatabaseAssetPath = 'assets/database/prebuilt.db';

/// 预编译数据库远端地址（Release 按需下载）
const String kPrebuiltDatabaseUrl =
    'https://children-rewards-data.oss-cn-hangzhou.aliyuncs.com/sqlite/25-12-31-prebuilt.db';

/// Vosk 模型远端地址
const String kVoskModelZipUrl =
    'https://children-rewards-data.oss-cn-hangzhou.aliyuncs.com/model/vosk-model-small-cn-0.22.zip';

/// Vosk 模型目录名
const String kVoskModelDirName = 'vosk-model-small-cn-0.22';

/// Vosk 模型资源根路径（仅 Debug 使用）
const String kVoskModelAssetBasePath =
    'assets/idiom_game/models/vosk-model-small-cn-0.22';

/// 是否使用打包内置资源（可用 --dart-define 覆盖）
const bool kUseBundledResources = bool.fromEnvironment(
  'USE_BUNDLED_RESOURCES',
  defaultValue: kDebugMode,
);

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 是否首次启动（null 表示尚未读取）
final appLaunchStateProvider = StateProvider<bool?>((ref) => null);

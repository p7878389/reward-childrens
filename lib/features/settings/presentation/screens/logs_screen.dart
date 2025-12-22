import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/logging/log_level.dart';
import 'package:children_rewards/shared/providers/database_provider.dart';
import 'package:children_rewards/shared/providers/pagination_provider.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';

/// 日志过滤器
class LogsFilter {
  final String? level;
  final String? tag;

  const LogsFilter({this.level, this.tag});

  LogsFilter copyWith({String? level, String? tag}) {
    return LogsFilter(
      level: level ?? this.level,
      tag: tag ?? this.tag,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogsFilter && level == other.level && tag == other.tag;

  @override
  int get hashCode => Object.hash(level, tag);
}

/// 日志分页 Notifier
class LogsPaginationNotifier extends PaginationNotifier<AppLog, LogsFilter> {
  final AppDatabase _db;

  LogsPaginationNotifier(this._db) : super(pageSize: 50);

  @override
  Future<List<AppLog>> fetchPage(int page, int pageSize, LogsFilter? filter) {
    return _db.queryLogs(
      level: filter?.level,
      tag: filter?.tag,
      limit: pageSize,
      offset: page * pageSize,
    );
  }
}

/// 日志分页 Provider
final logsPaginationProvider =
    StateNotifierProvider.autoDispose<LogsPaginationNotifier, PaginationState<AppLog>>((ref) {
  final db = ref.watch(databaseProvider);
  return LogsPaginationNotifier(db);
});

/// 当前过滤器 Provider
final logsFilterProvider = StateProvider<LogsFilter>((ref) => const LogsFilter());

class LogsScreen extends ConsumerStatefulWidget {
  const LogsScreen({super.key});

  @override
  ConsumerState<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends ConsumerState<LogsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // 初始加载
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(logsPaginationProvider.notifier).refresh();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(logsPaginationProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filter = ref.watch(logsFilterProvider);
    final paginationState = ref.watch(logsPaginationProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                children: [
                  HeaderButton(icon: Icons.arrow_back_ios_new_rounded, onTap: () => Navigator.pop(context)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      l10n.logs.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  HeaderButton(icon: Icons.refresh_rounded, onTap: () => ref.read(logsPaginationProvider.notifier).refresh(filter)),
                  const SizedBox(width: 12),
                  HeaderButton(icon: Icons.delete_outline_rounded, onTap: () => _confirmClearLogs(context, ref, l10n)),
                ],
              ),
            ),

            // Filter Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CommonFilterTabs(
                selectedValue: filter.level ?? 'all',
                onSelect: (val) {
                  final newLevel = val == 'all' ? null : val;
                  // 直接创建新的 LogsFilter，避免 copyWith 无法正确处理 null 值的问题
                  final newFilter = LogsFilter(level: newLevel, tag: filter.tag);
                  ref.read(logsFilterProvider.notifier).state = newFilter;
                  ref.read(logsPaginationProvider.notifier).refresh(newFilter);
                },
                tabs: [
                  FilterTabData(label: l10n.all, value: 'all'),
                  const FilterTabData(label: 'ERROR', value: 'error'),
                  const FilterTabData(label: 'WARN', value: 'warning'),
                  const FilterTabData(label: 'INFO', value: 'info'),
                  const FilterTabData(label: 'DEBUG', value: 'debug'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Logs List
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: _buildLogsList(paginationState, l10n),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLogsList(PaginationState<AppLog> state, AppLocalizations l10n) {
    if (state.items.isEmpty && !state.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.terminal_rounded, size: 48, color: Colors.white.withOpacity(0.2)),
            const SizedBox(height: 16),
            Text(l10n.noLogsFound, style: TextStyle(color: Colors.white.withOpacity(0.5), fontFamily: 'monospace')),
          ],
        ),
      );
    }

    if (state.items.isEmpty && state.isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: state.items.length + (state.hasMore ? 1 : 0),
      separatorBuilder: (_, __) => Divider(height: 1, color: Colors.white.withOpacity(0.1)),
      itemBuilder: (context, index) {
        if (index == state.items.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          );
        }
        return _buildLogItem(state.items[index]);
      },
    );
  }

  Widget _buildLogItem(AppLog log) {
    final level = LogLevel.fromString(log.level);
    final levelColor = _getLevelColor(level);
    final time = _formatTime(log.createdAt);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: levelColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  level.displayName.substring(0, 1),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                    color: levelColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '[${log.tag}]',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            log.message,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: level == LogLevel.error ? const Color(0xFFFF6B6B) : Colors.white.withOpacity(0.9),
              height: 1.3,
            ),
          ),
          if (log.stackTrace != null) ...[
            const SizedBox(height: 4),
            Text(
              log.stackTrace!,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'monospace',
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getLevelColor(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return const Color(0xFF9CA3AF); // Grey
      case LogLevel.info:
        return const Color(0xFF34D399); // Green
      case LogLevel.warning:
        return const Color(0xFFFBBF24); // Yellow
      case LogLevel.error:
        return const Color(0xFFFF6B6B); // Red
      case LogLevel.none:
        return const Color(0xFF6B7280); // Dark grey
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final isToday = time.year == now.year && time.month == now.month && time.day == now.day;

    final timeStr = '${time.hour.toString().padLeft(2, '0')}:'
                    '${time.minute.toString().padLeft(2, '0')}:'
                    '${time.second.toString().padLeft(2, '0')}';

    if (isToday) {
      return timeStr;
    } else {
      return '${time.month}/${time.day} $timeStr';
    }
  }

  void _confirmClearLogs(BuildContext context, WidgetRef ref, AppLocalizations l10n) async {
    final confirmed = await AppDialogs.showDeleteConfirm(
      context: context,
      title: l10n.clearLogsTitle,
      message: l10n.clearLogsMessage,
      confirmText: l10n.confirm,
    );

    if (confirmed) {
      await ref.read(databaseProvider).clearAllLogs();
      ref.read(logsPaginationProvider.notifier).refresh();
    }
  }
}

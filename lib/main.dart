import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:children_rewards/core/services/logger_service.dart';
import 'package:children_rewards/core/services/error_handler_service.dart';
import 'package:children_rewards/core/logging/app_logger.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/app/navigation/main_wrapper.dart';
import 'package:children_rewards/core/providers/locale_provider.dart';
import 'package:children_rewards/shared/providers/database_provider.dart';

void main() {
  // 初始化日志服务
  Logger.init();
  logInfo('App starting...', tag: 'Main');

  // 初始化全局错误处理
  ErrorHandler.init();

  // 使用错误处理器运行应用（在同一 Zone 中初始化 Flutter 绑定）
  ErrorHandler.runAppWithErrorHandler(
    Builder(
      builder: (context) {
        // 配置沉浸式状态栏（需要在 Widget 树中配置）
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.background,
          systemNavigationBarIconBrightness: Brightness.dark,
        ));
        return const ProviderScope(
          child: ChildrenRewardsApp(),
        );
      },
    ),
    ensureInitialized: true,
  );
}

class ChildrenRewardsApp extends ConsumerStatefulWidget {
  const ChildrenRewardsApp({super.key});

  @override
  ConsumerState<ChildrenRewardsApp> createState() => _ChildrenRewardsAppState();
}

class _ChildrenRewardsAppState extends ConsumerState<ChildrenRewardsApp> {
  @override
  void initState() {
    super.initState();
    // 初始化数据库日志器（延迟初始化，确保 ProviderScope 已就绪）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final db = ref.read(databaseProvider);
      AppLogger.instance.init(db);
      logInfo('Database logger initialized', tag: 'Main');
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'Children Rewards',
      debugShowCheckedModeBanner: false,
      locale: locale,

      // Localization Configuration
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          surface: AppColors.surface,
          primary: AppColors.primary,
          secondary: AppColors.textSecondary,
        ),
        scaffoldBackgroundColor: AppColors.background,
        // 配置 AppBar 默认状态栏样式
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        textTheme: GoogleFonts.plusJakartaSansTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: AppColors.textMain,
            displayColor: AppColors.textMain,
          ),
        ),
        useMaterial3: true,
      ),
      home: const MainWrapper(),
    );
  }
}

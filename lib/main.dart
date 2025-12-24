import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:children_rewards/l10n/app_localizations.dart';
import 'package:children_rewards/core/services/logger_service.dart';
import 'package:children_rewards/core/services/error_handler_service.dart';
import 'package:children_rewards/core/services/file_storage_service.dart';
import 'package:children_rewards/core/services/storage_migration_service.dart';
import 'package:children_rewards/core/logging/app_logger.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/app/navigation/main_wrapper.dart';
import 'package:children_rewards/core/providers/locale_provider.dart';
import 'package:children_rewards/shared/providers/database_provider.dart';

void main() {
  // 在同一个 Zone 中初始化和运行应用
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
    onInit: () async {
      // 初始化文件存储服务（必须最先初始化）
      await FileStorageService.init();

      // 初始化日志服务（依赖 FileStorageService）
      Logger.init();
      logInfo('App starting...', tag: 'Main');
      logInfo('FileStorageService initialized', tag: 'Main');

      // 执行存储迁移（后台执行，不阻塞启动）
      StorageMigrationService.migrateIfNeeded().then((_) {
        logInfo('Storage migration check completed', tag: 'Main');
      }).catchError((e) {
        logError('Storage migration failed', tag: 'Main', error: e);
      });
    },
  );
}

class ChildrenRewardsApp extends ConsumerStatefulWidget {
  const ChildrenRewardsApp({super.key});

  @override
  ConsumerState<ChildrenRewardsApp> createState() => _ChildrenRewardsAppState();
}

class _ChildrenRewardsAppState extends ConsumerState<ChildrenRewardsApp> {
  static const _firstLaunchKey = 'first_launch_done';
  bool _firstLaunchChecked = false;
  bool _isFirstLaunch = false;

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final done = prefs.getBool(_firstLaunchKey) ?? false;
    if (!mounted) return;
    if (done) {
      setState(() {
        _firstLaunchChecked = true;
        _isFirstLaunch = false;
      });
      return;
    }

    setState(() {
      _firstLaunchChecked = true;
      _isFirstLaunch = true;
    });

    Future.delayed(const Duration(milliseconds: 600), () async {
      if (!mounted) return;
      await prefs.setBool(_firstLaunchKey, true);
      if (!mounted) return;
      setState(() {
        _isFirstLaunch = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
    // 首帧后预热关键资源，降低首次打开卡顿
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      precacheImage(const AssetImage('assets/app_icon.png'), context);
    });
    // 初始化数据库日志器（延迟初始化，确保 ProviderScope 已就绪）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 延迟 3 秒初始化数据库日志，避免占用启动资源导致掉帧
      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;
        final db = ref.read(databaseProvider);
        AppLogger.instance.init(db);
        // 禁止 AppLogger 输出到控制台，避免与 LoggerService 重复
        AppLogger.instance.enableConsoleOutput = false;
        logInfo('Database logger initialized', tag: 'Main');
      });
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
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: _firstLaunchChecked && _isFirstLaunch
          ? const _FirstLaunchPlaceholder()
          : const MainWrapper(),
    );
  }
}

class _FirstLaunchPlaceholder extends StatelessWidget {
  const _FirstLaunchPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/app_icon.png',
              width: 80,
              height: 80,
              cacheWidth: 160,
              cacheHeight: 160,
            ),
            const SizedBox(height: 24),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

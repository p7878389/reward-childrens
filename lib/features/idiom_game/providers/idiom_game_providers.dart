import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/shared/providers/database_provider.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_dao.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_game_settings_dao.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_failure_records_dao.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_game_records_dao.dart';
import 'package:children_rewards/features/idiom_game/data/services/idiom_game_service_impl.dart';
import 'package:children_rewards/features/idiom_game/domain/services/idiom_game_service.dart';
import 'package:children_rewards/features/idiom_game/services/resource_download_service.dart';
import 'package:children_rewards/features/idiom_game/services/tts_service.dart';
import 'package:children_rewards/features/idiom_game/services/speech_recognition_service.dart';
import 'package:children_rewards/features/idiom_game/services/idiom_data_importer.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_grade_progress_dao.dart';
import 'package:children_rewards/core/database/app_database.dart';
import 'package:children_rewards/features/idiom_game/services/idiom_puzzle_service_impl.dart';
import 'package:children_rewards/features/idiom_game/domain/services/idiom_puzzle_service.dart';
import 'package:children_rewards/features/idiom_game/presentation/providers/idiom_puzzle_provider.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_engagement_dao.dart';
import 'package:children_rewards/features/idiom_game/data/dao/idiom_puzzle_records_dao.dart';
import 'package:children_rewards/features/points/providers/point_records_providers.dart';
import 'package:children_rewards/features/rule/providers/rules_providers.dart';

// ============ DAO Providers ============

final idiomDaoProvider = Provider<IdiomDao>((ref) {
  final db = ref.watch(databaseProvider);
  return IdiomDao(db);
});

final idiomGameSettingsDaoProvider = Provider<IdiomGameSettingsDao>((ref) {
  final db = ref.watch(databaseProvider);
  return IdiomGameSettingsDao(db);
});

final idiomGameRecordsDaoProvider = Provider<IdiomGameRecordsDao>((ref) {
  final db = ref.watch(databaseProvider);
  return IdiomGameRecordsDao(db);
});

final idiomFailureRecordsDaoProvider = Provider<IdiomFailureRecordsDao>((ref) {
  final db = ref.watch(databaseProvider);
  return IdiomFailureRecordsDao(db);
});

final idiomGradeProgressDaoProvider = Provider<IdiomGradeProgressDao>((ref) {
  final db = ref.watch(databaseProvider);
  return IdiomGradeProgressDao(db);
});

final idiomEngagementDaoProvider = Provider<IdiomEngagementDao>((ref) {
  final db = ref.watch(databaseProvider);
  return IdiomEngagementDao(db);
});

final idiomPuzzleRecordsDaoProvider = Provider<IdiomPuzzleRecordsDao>((ref) {
  final db = ref.watch(databaseProvider);
  return IdiomPuzzleRecordsDao(db);
});

// ============ Service Providers ============

/// 年级进度 Provider
final idiomGradeProgressProvider = FutureProvider.family<List<IdiomGradeProgressData>, int>((ref, childId) async {
  final dao = ref.watch(idiomGradeProgressDaoProvider);
  await dao.initializeProgress(childId);
  return dao.getAllProgress(childId);
});

final resourceDownloadServiceProvider = Provider<ResourceDownloadService>((ref) {
  final importer = ref.watch(idiomDataImporterProvider);
  final service = ResourceDownloadService(importer);
  ref.onDispose(() => service.dispose());
  return service;
});

final ttsServiceProvider = Provider<TtsService>((ref) {
  final service = TtsService();
  ref.onDispose(() => service.dispose());
  return service;
});

final speechRecognitionServiceProvider = Provider<SpeechRecognitionService>((ref) {
  final service = SpeechRecognitionService();
  ref.onDispose(() => service.dispose());
  return service;
});

final idiomDataImporterProvider = Provider<IdiomDataImporter>((ref) {
  final db = ref.watch(databaseProvider);
  return IdiomDataImporter(db);
});

/// 成语游戏主服务 Provider
final idiomGameServiceProvider = Provider<IdiomGameService>((ref) {
  final idiomDao = ref.watch(idiomDaoProvider);
  final settingsDao = ref.watch(idiomGameSettingsDaoProvider);
  final recordsDao = ref.watch(idiomGameRecordsDaoProvider);
  final failureRecordsDao = ref.watch(idiomFailureRecordsDaoProvider);
  final engagementDao = ref.watch(idiomEngagementDaoProvider);
  final importer = ref.watch(idiomDataImporterProvider);
  return IdiomGameServiceImpl(idiomDao, settingsDao, recordsDao, failureRecordsDao, engagementDao, importer);
});

// ============ Puzzle Game Providers ============

final idiomPuzzleServiceProvider = Provider<IdiomPuzzleService>((ref) {
  final dao = ref.watch(idiomDaoProvider);
  final engagementDao = ref.watch(idiomEngagementDaoProvider);
  final recordsDao = ref.watch(idiomPuzzleRecordsDaoProvider);
  return IdiomPuzzleServiceImpl(dao, engagementDao, recordsDao);
});

final idiomPuzzleProvider = StateNotifierProvider.autoDispose.family<IdiomPuzzleNotifier, IdiomPuzzleState, int>((ref, childId) {
  final service = ref.watch(idiomPuzzleServiceProvider);
  final pointsRepo = ref.watch(pointRecordsRepositoryProvider);
  final rulesRepo = ref.watch(rulesRepositoryProvider);
  final settingsDao = ref.watch(idiomGameSettingsDaoProvider);
  return IdiomPuzzleNotifier(service, pointsRepo, rulesRepo, settingsDao, childId, ref);
});

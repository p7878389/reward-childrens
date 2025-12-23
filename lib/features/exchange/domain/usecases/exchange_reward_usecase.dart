import 'package:flutter/foundation.dart';
import 'package:children_rewards/core/usecases/usecases.dart';
import 'package:children_rewards/core/exceptions/app_exceptions.dart';
import 'package:children_rewards/features/exchange/domain/repositories/i_exchange_repository.dart';
import 'package:children_rewards/features/badges/domain/entities/badge_entity.dart';
import 'package:children_rewards/features/badges/domain/usecases/check_and_award_badges_usecase.dart';

/// 兑换奖励用例参数
@immutable
class ExchangeRewardParams {
  /// 宝贝ID
  final int childId;

  /// 奖励商品ID
  final int rewardId;

  /// 备注（可选）
  final String? note;

  const ExchangeRewardParams({
    required this.childId,
    required this.rewardId,
    this.note,
  });
}

/// 兑换结果
@immutable
class ExchangeResult {
  final bool success;
  final List<BadgeEntity> awardedBadges;
  final int bonusPoints;

  const ExchangeResult({
    required this.success,
    this.awardedBadges = const [],
    this.bonusPoints = 0,
  });

  bool get hasBadges => awardedBadges.isNotEmpty;
}

/// 兑换奖励用例
///
/// 处理完整的商品兑换业务流程：
/// 1. 验证商品状态（是否激活）
/// 2. 验证积分是否充足
/// 3. 验证库存是否充足
/// 4. 扣减库存
/// 5. 创建兑换记录
/// 6. 扣减积分
/// 7. 创建积分流水
/// 8. 触发徽章检测
///
/// 所有操作在事务中执行，保证数据一致性。
class ExchangeRewardUseCase extends UseCase<ExchangeRewardParams, ExchangeResult> {
  final IExchangeRepository _exchangeRepository;
  final CheckAndAwardBadgesUseCase _checkBadgesUseCase;

  ExchangeRewardUseCase(
    this._exchangeRepository,
    this._checkBadgesUseCase,
  );

  @override
  Future<Result<ExchangeResult>> execute(ExchangeRewardParams params) async {
    try {
      // 1. 执行兑换
      await _exchangeRepository.exchangeReward(
        childId: params.childId,
        rewardId: params.rewardId,
        note: params.note,
      );

      // 2. 触发徽章检测
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
    } on InsufficientFundsException catch (e) {
      return Result.failure('积分不足，无法兑换', exception: e);
    } on OutOfStockException catch (e) {
      return Result.failure('商品库存不足', exception: e);
    } on RewardInactiveException catch (e) {
      return Result.failure('商品已下架', exception: e);
    } on AppException catch (e) {
      return Result.failure(e.message, exception: e);
    } catch (e, stackTrace) {
      return Result.failure('兑换失败：${e.toString()}', stackTrace: stackTrace);
    }
  }
}
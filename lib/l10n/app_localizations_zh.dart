// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '儿童奖励';

  @override
  String get welcomeTitle => '开启奖励之旅';

  @override
  String get noChildrenYet => '添加第一个宝贝开始吧！';

  @override
  String get addAnotherChild => '添加宝贝';

  @override
  String get manageChild => '管理宝贝';

  @override
  String get pointsHistory => '积分历史';

  @override
  String get customRules => '自定义规则';

  @override
  String get rewardHistory => '兑换历史';

  @override
  String get deleteChildProfile => '删除档案';

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String get noRecordsFound => '暂无记录';

  @override
  String get totalBalance => '总余额';

  @override
  String get totalEarned => '总获得';

  @override
  String get totalDeducted => '总扣除';

  @override
  String get confirm => '确认';

  @override
  String get cancel => '取消';

  @override
  String get yesDelete => '删除';

  @override
  String get deleteConfirmMessage => '此操作无法撤销。';

  @override
  String get rewardsStore => '奖励商店';

  @override
  String get store => '商店';

  @override
  String get all => '全部';

  @override
  String get privileges => '特权';

  @override
  String get toys => '玩具';

  @override
  String get snacks => '零食';

  @override
  String get earned => '获得';

  @override
  String get spent => '支出';

  @override
  String get stars => '星星';

  @override
  String get totalItems => '兑换总数';

  @override
  String get totalSpent => '总消耗';

  @override
  String get years => '岁';

  @override
  String get availableStars => '可用星星';

  @override
  String get boy => '男孩';

  @override
  String get girl => '女孩';

  @override
  String get childName => '宝贝姓名';

  @override
  String get gender => '性别';

  @override
  String get birthdayOptional => '生日 (选填)';

  @override
  String get selectDate => '选择日期';

  @override
  String get addProfile => '添加档案';

  @override
  String get deleteProfile => '确认删除？';

  @override
  String deleteChildTitle(String name) {
    return '删除 $name？';
  }

  @override
  String get deleteUndone => '此操作无法撤销。';

  @override
  String get editProfile => '编辑档案';

  @override
  String get saveChanges => '保存修改';

  @override
  String get dataAndRules => '数据与规则';

  @override
  String get pointsHistorySubtitle => '查看完整积分记录';

  @override
  String get customRulesSubtitle => '管理奖惩规则';

  @override
  String rewardHistorySubtitle(String name) {
    return '$name的兑换记录';
  }

  @override
  String get tapPhoto => '点击上传照片';

  @override
  String get choosePhotoSource => '选择照片来源';

  @override
  String get takePhoto => '拍照';

  @override
  String get chooseFromGallery => '相册';

  @override
  String get createProfile => '创建档案';

  @override
  String get delete => '删除';

  @override
  String get reward => '奖励';

  @override
  String get punish => '惩罚';

  @override
  String get selectRule => '选择规则';

  @override
  String get chooseRule => '选择一个规则...';

  @override
  String get points => '积分';

  @override
  String get note => '备注';

  @override
  String get optional => '(选填)';

  @override
  String get addRecord => '添加记录';

  @override
  String get addRecordConfirmTitle => '添加记录？';

  @override
  String get addRecordConfirmMessage => '确认添加此记录？';

  @override
  String get manageRules => '规则管理';

  @override
  String get rules => '奖惩规则';

  @override
  String get deleteRuleTitle => '删除规则？';

  @override
  String deleteRuleConfirm(String name) {
    return '确定要删除 \"$name\" 吗？';
  }

  @override
  String get newRule => '新建规则';

  @override
  String get editRule => '编辑规则';

  @override
  String get ruleName => '规则名称';

  @override
  String get defaultPoints => '默认分数';

  @override
  String get chooseIcon => '选择图标';

  @override
  String get createRule => '创建规则';

  @override
  String get saveRuleTitle => '保存规则？';

  @override
  String get saveRuleMessage => '保存修改？';

  @override
  String get swipeToDelete => '左滑删除';

  @override
  String deleteConfirm(String name) {
    return '删除 \"$name\"？';
  }

  @override
  String get goodMorning => '早上好！';

  @override
  String get goodAfternoon => '下午好！';

  @override
  String get goodEvening => '晚上好！';

  @override
  String get whoIsEarning => '谁正在赢取';

  @override
  String get todayQuestion => '？';

  @override
  String get manageRewards => '奖励管理';

  @override
  String get rewardDetail => '奖励详情';

  @override
  String get addReward => '添加奖励';

  @override
  String get editReward => '编辑奖励';

  @override
  String get rewardName => '商品名称';

  @override
  String get category => '分类';

  @override
  String get description => '描述';

  @override
  String get unlimitedStock => '不限库存';

  @override
  String get availableQuantity => '可用数量';

  @override
  String get confirmRedemption => '确认兑换';

  @override
  String confirmRedeemMessage(int points, String name) {
    return '确定花费 $points 颗星星兑换 $name？';
  }

  @override
  String get redeemSuccess => '兑换成功！';

  @override
  String get outOfStock => '库存不足';

  @override
  String get redeemNow => '立即兑换';

  @override
  String get needMoreStars => '星星不足';

  @override
  String insufficientPoints(int diff) {
    return '还差 $diff 颗星星';
  }

  @override
  String get deleteRewardTitle => '删除奖励？';

  @override
  String deleteRewardConfirm(String name) {
    return '确定要删除 \"$name\" 吗？';
  }

  @override
  String get settings => '设置';

  @override
  String get language => '语言';

  @override
  String get systemDefault => '系统默认';

  @override
  String get dataManagement => '数据管理';

  @override
  String get clearAllData => '清空所有数据';

  @override
  String get clearDataTitle => '清空所有数据？';

  @override
  String get clearDataMessage => '删除所有数据且无法撤销。';

  @override
  String get deleteEverything => '全部删除';

  @override
  String get dataClearedSuccess => '数据已清空';

  @override
  String get addSuccess => '添加成功';

  @override
  String get appVersion => '版本';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get noteRequiredForCustomRule => '请填写备注';

  @override
  String get pointsMustBePositive => '积分须大于0';

  @override
  String get pleaseSelectRule => '请选择规则';

  @override
  String get ruleCleanBedroom => '整理房间';

  @override
  String get ruleFinishHomework => '完成作业';

  @override
  String get ruleWashDishes => '洗碗';

  @override
  String get ruleWalkTheDog => '遛狗';

  @override
  String get rulePracticeInstrument => '练习乐器';

  @override
  String get ruleTantrum => '发脾气';

  @override
  String get ruleFighting => '打架';

  @override
  String get ruleNotListening => '不听话';

  @override
  String get ruleCustomReward => '自定义奖励';

  @override
  String get ruleCustomPenalty => '自定义惩罚';

  @override
  String get ruleExchange => '兑换';

  @override
  String get fieldRequired => '此项必填';

  @override
  String get invalidNumber => '请输入数字';

  @override
  String get numberMustBePositive => '须大于0';

  @override
  String get nameRequired => '请填写名称';

  @override
  String get nameTooLong => '名称不能超过20个字符';

  @override
  String get operationFailed => '操作失败，请重试';

  @override
  String get priceRequired => '请填写价格';

  @override
  String get stockRequired => '请填写库存';

  @override
  String deleteConfirmMessageCommon(String name) {
    return '确定要删除 \"$name\" 吗？';
  }

  @override
  String get ruleActiveStatus => '上架';

  @override
  String get rewardActiveStatus => '上架';

  @override
  String get saveSuccess => '保存成功';

  @override
  String get checkin => '签到';

  @override
  String get dailyCheckin => '每日签到';

  @override
  String get checkinToEarn => '签到获得奖励';

  @override
  String get checkinSuccess => '签到成功！';

  @override
  String get alreadyCheckedin => '今日已签到';

  @override
  String consecutiveCheckin(int days) {
    return '连续签到 $days 天';
  }

  @override
  String get growthBadges => '成长徽章';

  @override
  String get viewAchievements => '查看成就徽章';

  @override
  String get acceptRewards => '开心收下';

  @override
  String get gotIt => '知道了';

  @override
  String get addDetails => '添加详情...';

  @override
  String get ruleNameDuplicate => '名称已存在';

  @override
  String get logs => '日志';

  @override
  String get allLevels => '全部级别';

  @override
  String get noLogsFound => '暂无日志';

  @override
  String get noDescription => '暂无描述';

  @override
  String get clearLogsTitle => '清空日志？';

  @override
  String get clearLogsMessage => '删除所有日志且无法撤销。';

  @override
  String get avatar => '头像';

  @override
  String get rewardImage => '奖励图片';

  @override
  String get other => '其他';

  @override
  String get idiomGame => '成语接龙';

  @override
  String get idiomGameDesc => '挑战成语接龙，锻炼词汇量';

  @override
  String get yourTurn => '你的回合';

  @override
  String get aiTurn => 'AI 回合';

  @override
  String get chainLength => '接龙长度';

  @override
  String get starsEarned => '获得星星';

  @override
  String get gameOver => '游戏结束';

  @override
  String get playAgain => '再来一局';

  @override
  String get backToHome => '返回首页';

  @override
  String get failureNextTip => '原本可以接：';

  @override
  String get learnMore => '了解更多';

  @override
  String get errorTitle => '出错了';

  @override
  String get retry => '重试';

  @override
  String get errorDetails => '错误详情';

  @override
  String get gameHall => '游戏大厅';

  @override
  String get mainQuest => '主线任务';

  @override
  String get specialTraining => '专项训练';

  @override
  String get idiomChainChallenge => '成语接龙 · 闯关';

  @override
  String get idiomCompletion => '成语补全';

  @override
  String get completeMissingCharacters => '补全缺失的汉字';

  @override
  String get guessIdiomByMeaning => '看意猜词';

  @override
  String get guessIdiomFromMeaning => '根据释义猜成语';

  @override
  String get myMistakeBook => '我的错题本';

  @override
  String get reviewAndLearn => '温故而知新';

  @override
  String ageYears(int age) {
    return '$age岁';
  }
}

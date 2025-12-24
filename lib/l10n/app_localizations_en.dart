// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Children Rewards';

  @override
  String get welcomeTitle => 'Reward Journey';

  @override
  String get noChildrenYet => 'Add your first child to start!';

  @override
  String get addAnotherChild => 'Add Child';

  @override
  String get manageChild => 'Manage Child';

  @override
  String get pointsHistory => 'Points History';

  @override
  String get customRules => 'Custom Rules';

  @override
  String get rewardHistory => 'Reward History';

  @override
  String get deleteChildProfile => 'Delete Profile';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get noRecordsFound => 'No records';

  @override
  String get totalBalance => 'Balance';

  @override
  String get totalEarned => 'Earned';

  @override
  String get totalDeducted => 'Deducted';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get yesDelete => 'Delete';

  @override
  String get deleteConfirmMessage => 'This cannot be undone.';

  @override
  String get rewardsStore => 'Store';

  @override
  String get store => 'Store';

  @override
  String get all => 'All';

  @override
  String get privileges => 'Privileges';

  @override
  String get toys => 'Toys';

  @override
  String get snacks => 'Snacks';

  @override
  String get earned => 'Earned';

  @override
  String get spent => 'Spent';

  @override
  String get stars => 'Stars';

  @override
  String get totalItems => 'Total Items';

  @override
  String get totalSpent => 'Total Spent';

  @override
  String get years => 'Years';

  @override
  String get availableStars => 'Available Stars';

  @override
  String get boy => 'Boy';

  @override
  String get girl => 'Girl';

  @override
  String get childName => 'Child\'s Name';

  @override
  String get gender => 'Gender';

  @override
  String get birthdayOptional => 'Birthday (Optional)';

  @override
  String get selectDate => 'Select Date';

  @override
  String get addProfile => 'Add Profile';

  @override
  String get deleteProfile => 'Delete Profile?';

  @override
  String deleteChildTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get deleteUndone => 'This cannot be undone.';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get dataAndRules => 'Data & Rules';

  @override
  String get pointsHistorySubtitle => 'Full timeline of earnings';

  @override
  String get customRulesSubtitle => 'Manage rules';

  @override
  String rewardHistorySubtitle(String name) {
    return '$name\'s rewards';
  }

  @override
  String get tapPhoto => 'Tap to upload';

  @override
  String get choosePhotoSource => 'Photo Source';

  @override
  String get takePhoto => 'Camera';

  @override
  String get chooseFromGallery => 'Gallery';

  @override
  String get createProfile => 'Create Profile';

  @override
  String get delete => 'Delete';

  @override
  String get reward => 'Reward';

  @override
  String get punish => 'Punish';

  @override
  String get selectRule => 'Select Rule';

  @override
  String get chooseRule => 'Choose a rule...';

  @override
  String get points => 'Points';

  @override
  String get note => 'Note';

  @override
  String get optional => '(Optional)';

  @override
  String get addRecord => 'Add Record';

  @override
  String get addRecordConfirmTitle => 'Add Record?';

  @override
  String get addRecordConfirmMessage => 'Confirm adding this record?';

  @override
  String get manageRules => 'Manage Rules';

  @override
  String get rules => 'Rules';

  @override
  String get deleteRuleTitle => 'Delete Rule?';

  @override
  String deleteRuleConfirm(String name) {
    return 'Delete \"$name\"';
  }

  @override
  String get newRule => 'New Rule';

  @override
  String get editRule => 'Edit Rule';

  @override
  String get ruleName => 'Rule Name';

  @override
  String get defaultPoints => 'Default Points';

  @override
  String get chooseIcon => 'Choose Icon';

  @override
  String get createRule => 'Create Rule';

  @override
  String get saveRuleTitle => 'Save Rule?';

  @override
  String get saveRuleMessage => 'Save changes?';

  @override
  String get swipeToDelete => 'Swipe to delete';

  @override
  String deleteConfirm(String name) {
    return 'Delete \"$name\"';
  }

  @override
  String get goodMorning => 'GOOD MORNING!';

  @override
  String get goodAfternoon => 'GOOD AFTERNOON!';

  @override
  String get goodEvening => 'GOOD EVENING!';

  @override
  String get whoIsEarning => 'Who is earning';

  @override
  String get todayQuestion => 'today?';

  @override
  String get manageRewards => 'Manage Rewards';

  @override
  String get rewardDetail => 'Reward Detail';

  @override
  String get addReward => 'Add Reward';

  @override
  String get editReward => 'Edit Reward';

  @override
  String get rewardName => 'Item Name';

  @override
  String get category => 'Category';

  @override
  String get description => 'Description';

  @override
  String get unlimitedStock => 'Unlimited Stock';

  @override
  String get availableQuantity => 'Quantity';

  @override
  String get confirmRedemption => 'Redeem?';

  @override
  String confirmRedeemMessage(int points, String name) {
    return 'Spend $points stars for $name?';
  }

  @override
  String get redeemSuccess => 'Redeemed!';

  @override
  String get outOfStock => 'Out of stock';

  @override
  String get redeemNow => 'Redeem Now';

  @override
  String get needMoreStars => 'Need stars';

  @override
  String insufficientPoints(int diff) {
    return 'Need $diff more stars';
  }

  @override
  String get deleteRewardTitle => 'Delete Reward?';

  @override
  String deleteRewardConfirm(String name) {
    return 'Delete \"$name\"';
  }

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get systemDefault => 'System Default';

  @override
  String get dataManagement => 'Data';

  @override
  String get clearAllData => 'Clear All Data';

  @override
  String get clearDataTitle => 'Clear All?';

  @override
  String get clearDataMessage => 'Delete all data. Permanent.';

  @override
  String get deleteEverything => 'Delete All';

  @override
  String get dataClearedSuccess => 'Data cleared';

  @override
  String get addSuccess => 'Success';

  @override
  String get appVersion => 'Version';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get noteRequiredForCustomRule => 'Note is required';

  @override
  String get pointsMustBePositive => 'Must be > 0';

  @override
  String get pleaseSelectRule => 'Select a rule';

  @override
  String get ruleCleanBedroom => 'Clean Bedroom';

  @override
  String get ruleFinishHomework => 'Finish Homework';

  @override
  String get ruleWashDishes => 'Wash Dishes';

  @override
  String get ruleWalkTheDog => 'Walk the Dog';

  @override
  String get rulePracticeInstrument => 'Practice Instrument';

  @override
  String get ruleTantrum => 'Tantrum';

  @override
  String get ruleFighting => 'Fighting';

  @override
  String get ruleNotListening => 'Not Listening';

  @override
  String get ruleCustomReward => 'Custom Reward';

  @override
  String get ruleCustomPenalty => 'Custom Penalty';

  @override
  String get ruleExchange => 'Exchange';

  @override
  String get fieldRequired => 'Required';

  @override
  String get invalidNumber => 'Enter a number';

  @override
  String get numberMustBePositive => 'Must be > 0';

  @override
  String get nameRequired => 'Name required';

  @override
  String get nameTooLong => 'Name cannot exceed 20 characters';

  @override
  String get operationFailed => 'Operation failed, please try again';

  @override
  String get priceRequired => 'Price required';

  @override
  String get stockRequired => 'Stock required';

  @override
  String deleteConfirmMessageCommon(String name) {
    return 'Delete \"$name\"';
  }

  @override
  String get ruleActiveStatus => 'Active';

  @override
  String get rewardActiveStatus => 'Active';

  @override
  String get saveSuccess => 'Saved successfully';

  @override
  String get checkin => 'Check-in';

  @override
  String get dailyCheckin => 'Daily Check-in';

  @override
  String get checkinToEarn => 'Check in to earn rewards';

  @override
  String get checkinSuccess => 'Check-in Success!';

  @override
  String get alreadyCheckedin => 'Already checked in today';

  @override
  String consecutiveCheckin(int days) {
    return 'Check-in streak: $days days';
  }

  @override
  String get growthBadges => 'Badges';

  @override
  String get viewAchievements => 'View your achievements';

  @override
  String get acceptRewards => 'Got it!';

  @override
  String get gotIt => 'Got it';

  @override
  String get addDetails => 'Add details...';

  @override
  String get ruleNameDuplicate => 'Name exists';

  @override
  String get logs => 'Logs';

  @override
  String get allLevels => 'All Levels';

  @override
  String get noLogsFound => 'No logs';

  @override
  String get noDescription => 'No description';

  @override
  String get clearLogsTitle => 'Clear Logs?';

  @override
  String get clearLogsMessage => 'Delete all logs. Permanent.';

  @override
  String get avatar => 'Avatar';

  @override
  String get rewardImage => 'Reward Image';

  @override
  String get other => 'Other';

  @override
  String get idiomGame => 'Idiom Chain';

  @override
  String get idiomGameDesc => 'Challenge idiom chain game, expand vocabulary';

  @override
  String get yourTurn => 'Your Turn';

  @override
  String get aiTurn => 'AI Turn';

  @override
  String get chainLength => 'Chain Length';

  @override
  String get starsEarned => 'Stars Earned';

  @override
  String get gameOver => 'Game Over';

  @override
  String get playAgain => 'Play Again';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get failureNextTip => 'Could have been:';

  @override
  String get learnMore => 'Learn More';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String get errorDetails => 'Error Details';

  @override
  String get gameHall => 'Game Hall';

  @override
  String get mainQuest => 'Main Quest';

  @override
  String get specialTraining => 'Special Training';

  @override
  String get idiomChainChallenge => 'Idiom Chain Challenge';

  @override
  String get idiomCompletion => 'Idiom Completion';

  @override
  String get completeMissingCharacters => 'Complete missing characters';

  @override
  String get guessIdiomByMeaning => 'Guess by Meaning';

  @override
  String get guessIdiomFromMeaning => 'Guess idiom from meaning';

  @override
  String get myMistakeBook => 'My Mistake Book';

  @override
  String get reviewAndLearn => 'Review and learn';

  @override
  String ageYears(int age) {
    return '$age yrs';
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Children Rewards'**
  String get appTitle;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Reward Journey'**
  String get welcomeTitle;

  /// No description provided for @noChildrenYet.
  ///
  /// In en, this message translates to:
  /// **'Add your first child to start!'**
  String get noChildrenYet;

  /// No description provided for @addAnotherChild.
  ///
  /// In en, this message translates to:
  /// **'Add Child'**
  String get addAnotherChild;

  /// No description provided for @manageChild.
  ///
  /// In en, this message translates to:
  /// **'Manage Child'**
  String get manageChild;

  /// No description provided for @pointsHistory.
  ///
  /// In en, this message translates to:
  /// **'Points History'**
  String get pointsHistory;

  /// No description provided for @customRules.
  ///
  /// In en, this message translates to:
  /// **'Custom Rules'**
  String get customRules;

  /// No description provided for @rewardHistory.
  ///
  /// In en, this message translates to:
  /// **'Reward History'**
  String get rewardHistory;

  /// No description provided for @deleteChildProfile.
  ///
  /// In en, this message translates to:
  /// **'Delete Profile'**
  String get deleteChildProfile;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @noRecordsFound.
  ///
  /// In en, this message translates to:
  /// **'No records'**
  String get noRecordsFound;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get totalBalance;

  /// No description provided for @totalEarned.
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get totalEarned;

  /// No description provided for @totalDeducted.
  ///
  /// In en, this message translates to:
  /// **'Deducted'**
  String get totalDeducted;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @yesDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get yesDelete;

  /// No description provided for @deleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone.'**
  String get deleteConfirmMessage;

  /// No description provided for @rewardsStore.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get rewardsStore;

  /// No description provided for @store.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get store;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @privileges.
  ///
  /// In en, this message translates to:
  /// **'Privileges'**
  String get privileges;

  /// No description provided for @toys.
  ///
  /// In en, this message translates to:
  /// **'Toys'**
  String get toys;

  /// No description provided for @snacks.
  ///
  /// In en, this message translates to:
  /// **'Snacks'**
  String get snacks;

  /// No description provided for @earned.
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get earned;

  /// No description provided for @spent.
  ///
  /// In en, this message translates to:
  /// **'Spent'**
  String get spent;

  /// No description provided for @stars.
  ///
  /// In en, this message translates to:
  /// **'Stars'**
  String get stars;

  /// No description provided for @totalItems.
  ///
  /// In en, this message translates to:
  /// **'Total Items'**
  String get totalItems;

  /// No description provided for @totalSpent.
  ///
  /// In en, this message translates to:
  /// **'Total Spent'**
  String get totalSpent;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get years;

  /// No description provided for @availableStars.
  ///
  /// In en, this message translates to:
  /// **'Available Stars'**
  String get availableStars;

  /// No description provided for @boy.
  ///
  /// In en, this message translates to:
  /// **'Boy'**
  String get boy;

  /// No description provided for @girl.
  ///
  /// In en, this message translates to:
  /// **'Girl'**
  String get girl;

  /// No description provided for @childName.
  ///
  /// In en, this message translates to:
  /// **'Child\'s Name'**
  String get childName;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @birthdayOptional.
  ///
  /// In en, this message translates to:
  /// **'Birthday (Optional)'**
  String get birthdayOptional;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @addProfile.
  ///
  /// In en, this message translates to:
  /// **'Add Profile'**
  String get addProfile;

  /// No description provided for @deleteProfile.
  ///
  /// In en, this message translates to:
  /// **'Delete Profile?'**
  String get deleteProfile;

  /// No description provided for @deleteChildTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}?'**
  String deleteChildTitle(String name);

  /// No description provided for @deleteUndone.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone.'**
  String get deleteUndone;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @dataAndRules.
  ///
  /// In en, this message translates to:
  /// **'Data & Rules'**
  String get dataAndRules;

  /// No description provided for @pointsHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Full timeline of earnings'**
  String get pointsHistorySubtitle;

  /// No description provided for @customRulesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage rules'**
  String get customRulesSubtitle;

  /// No description provided for @rewardHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'{name}\'s rewards'**
  String rewardHistorySubtitle(String name);

  /// No description provided for @tapPhoto.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload'**
  String get tapPhoto;

  /// No description provided for @choosePhotoSource.
  ///
  /// In en, this message translates to:
  /// **'Photo Source'**
  String get choosePhotoSource;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get chooseFromGallery;

  /// No description provided for @createProfile.
  ///
  /// In en, this message translates to:
  /// **'Create Profile'**
  String get createProfile;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @reward.
  ///
  /// In en, this message translates to:
  /// **'Reward'**
  String get reward;

  /// No description provided for @punish.
  ///
  /// In en, this message translates to:
  /// **'Punish'**
  String get punish;

  /// No description provided for @selectRule.
  ///
  /// In en, this message translates to:
  /// **'Select Rule'**
  String get selectRule;

  /// No description provided for @chooseRule.
  ///
  /// In en, this message translates to:
  /// **'Choose a rule...'**
  String get chooseRule;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'(Optional)'**
  String get optional;

  /// No description provided for @addRecord.
  ///
  /// In en, this message translates to:
  /// **'Add Record'**
  String get addRecord;

  /// No description provided for @addRecordConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Record?'**
  String get addRecordConfirmTitle;

  /// No description provided for @addRecordConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Confirm adding this record?'**
  String get addRecordConfirmMessage;

  /// No description provided for @manageRules.
  ///
  /// In en, this message translates to:
  /// **'Manage Rules'**
  String get manageRules;

  /// No description provided for @rules.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get rules;

  /// No description provided for @deleteRuleTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Rule?'**
  String get deleteRuleTitle;

  /// No description provided for @deleteRuleConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"'**
  String deleteRuleConfirm(String name);

  /// No description provided for @newRule.
  ///
  /// In en, this message translates to:
  /// **'New Rule'**
  String get newRule;

  /// No description provided for @editRule.
  ///
  /// In en, this message translates to:
  /// **'Edit Rule'**
  String get editRule;

  /// No description provided for @ruleName.
  ///
  /// In en, this message translates to:
  /// **'Rule Name'**
  String get ruleName;

  /// No description provided for @defaultPoints.
  ///
  /// In en, this message translates to:
  /// **'Default Points'**
  String get defaultPoints;

  /// No description provided for @chooseIcon.
  ///
  /// In en, this message translates to:
  /// **'Choose Icon'**
  String get chooseIcon;

  /// No description provided for @createRule.
  ///
  /// In en, this message translates to:
  /// **'Create Rule'**
  String get createRule;

  /// No description provided for @saveRuleTitle.
  ///
  /// In en, this message translates to:
  /// **'Save Rule?'**
  String get saveRuleTitle;

  /// No description provided for @saveRuleMessage.
  ///
  /// In en, this message translates to:
  /// **'Save changes?'**
  String get saveRuleMessage;

  /// No description provided for @swipeToDelete.
  ///
  /// In en, this message translates to:
  /// **'Swipe to delete'**
  String get swipeToDelete;

  /// No description provided for @deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"'**
  String deleteConfirm(String name);

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'GOOD MORNING!'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'GOOD AFTERNOON!'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'GOOD EVENING!'**
  String get goodEvening;

  /// No description provided for @whoIsEarning.
  ///
  /// In en, this message translates to:
  /// **'Who is earning'**
  String get whoIsEarning;

  /// No description provided for @todayQuestion.
  ///
  /// In en, this message translates to:
  /// **'today?'**
  String get todayQuestion;

  /// No description provided for @manageRewards.
  ///
  /// In en, this message translates to:
  /// **'Manage Rewards'**
  String get manageRewards;

  /// No description provided for @rewardDetail.
  ///
  /// In en, this message translates to:
  /// **'Reward Detail'**
  String get rewardDetail;

  /// No description provided for @addReward.
  ///
  /// In en, this message translates to:
  /// **'Add Reward'**
  String get addReward;

  /// No description provided for @editReward.
  ///
  /// In en, this message translates to:
  /// **'Edit Reward'**
  String get editReward;

  /// No description provided for @rewardName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get rewardName;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @unlimitedStock.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Stock'**
  String get unlimitedStock;

  /// No description provided for @availableQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get availableQuantity;

  /// No description provided for @confirmRedemption.
  ///
  /// In en, this message translates to:
  /// **'Redeem?'**
  String get confirmRedemption;

  /// No description provided for @confirmRedeemMessage.
  ///
  /// In en, this message translates to:
  /// **'Spend {points} stars for {name}?'**
  String confirmRedeemMessage(int points, String name);

  /// No description provided for @redeemSuccess.
  ///
  /// In en, this message translates to:
  /// **'Redeemed!'**
  String get redeemSuccess;

  /// No description provided for @outOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get outOfStock;

  /// No description provided for @redeemNow.
  ///
  /// In en, this message translates to:
  /// **'Redeem Now'**
  String get redeemNow;

  /// No description provided for @needMoreStars.
  ///
  /// In en, this message translates to:
  /// **'Need stars'**
  String get needMoreStars;

  /// No description provided for @insufficientPoints.
  ///
  /// In en, this message translates to:
  /// **'Need {diff} more stars'**
  String insufficientPoints(int diff);

  /// No description provided for @deleteRewardTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Reward?'**
  String get deleteRewardTitle;

  /// No description provided for @deleteRewardConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"'**
  String deleteRewardConfirm(String name);

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @dataManagement.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get dataManagement;

  /// No description provided for @clearAllData.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllData;

  /// No description provided for @clearDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear All?'**
  String get clearDataTitle;

  /// No description provided for @clearDataMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete all data. Permanent.'**
  String get clearDataMessage;

  /// No description provided for @deleteEverything.
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get deleteEverything;

  /// No description provided for @dataClearedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data cleared'**
  String get dataClearedSuccess;

  /// No description provided for @addSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get addSuccess;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get appVersion;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @noteRequiredForCustomRule.
  ///
  /// In en, this message translates to:
  /// **'Note is required'**
  String get noteRequiredForCustomRule;

  /// No description provided for @pointsMustBePositive.
  ///
  /// In en, this message translates to:
  /// **'Must be > 0'**
  String get pointsMustBePositive;

  /// No description provided for @pleaseSelectRule.
  ///
  /// In en, this message translates to:
  /// **'Select a rule'**
  String get pleaseSelectRule;

  /// No description provided for @ruleCleanBedroom.
  ///
  /// In en, this message translates to:
  /// **'Clean Bedroom'**
  String get ruleCleanBedroom;

  /// No description provided for @ruleFinishHomework.
  ///
  /// In en, this message translates to:
  /// **'Finish Homework'**
  String get ruleFinishHomework;

  /// No description provided for @ruleWashDishes.
  ///
  /// In en, this message translates to:
  /// **'Wash Dishes'**
  String get ruleWashDishes;

  /// No description provided for @ruleWalkTheDog.
  ///
  /// In en, this message translates to:
  /// **'Walk the Dog'**
  String get ruleWalkTheDog;

  /// No description provided for @rulePracticeInstrument.
  ///
  /// In en, this message translates to:
  /// **'Practice Instrument'**
  String get rulePracticeInstrument;

  /// No description provided for @ruleTantrum.
  ///
  /// In en, this message translates to:
  /// **'Tantrum'**
  String get ruleTantrum;

  /// No description provided for @ruleFighting.
  ///
  /// In en, this message translates to:
  /// **'Fighting'**
  String get ruleFighting;

  /// No description provided for @ruleNotListening.
  ///
  /// In en, this message translates to:
  /// **'Not Listening'**
  String get ruleNotListening;

  /// No description provided for @ruleCustomReward.
  ///
  /// In en, this message translates to:
  /// **'Custom Reward'**
  String get ruleCustomReward;

  /// No description provided for @ruleCustomPenalty.
  ///
  /// In en, this message translates to:
  /// **'Custom Penalty'**
  String get ruleCustomPenalty;

  /// No description provided for @ruleExchange.
  ///
  /// In en, this message translates to:
  /// **'Exchange'**
  String get ruleExchange;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get fieldRequired;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a number'**
  String get invalidNumber;

  /// No description provided for @numberMustBePositive.
  ///
  /// In en, this message translates to:
  /// **'Must be > 0'**
  String get numberMustBePositive;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name required'**
  String get nameRequired;

  /// No description provided for @nameTooLong.
  ///
  /// In en, this message translates to:
  /// **'Name cannot exceed 20 characters'**
  String get nameTooLong;

  /// No description provided for @operationFailed.
  ///
  /// In en, this message translates to:
  /// **'Operation failed, please try again'**
  String get operationFailed;

  /// No description provided for @priceRequired.
  ///
  /// In en, this message translates to:
  /// **'Price required'**
  String get priceRequired;

  /// No description provided for @stockRequired.
  ///
  /// In en, this message translates to:
  /// **'Stock required'**
  String get stockRequired;

  /// No description provided for @deleteConfirmMessageCommon.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"'**
  String deleteConfirmMessageCommon(String name);

  /// No description provided for @ruleActiveStatus.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get ruleActiveStatus;

  /// No description provided for @rewardActiveStatus.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get rewardActiveStatus;

  /// No description provided for @saveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get saveSuccess;

  /// No description provided for @checkin.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get checkin;

  /// No description provided for @dailyCheckin.
  ///
  /// In en, this message translates to:
  /// **'Daily Check-in'**
  String get dailyCheckin;

  /// No description provided for @checkinToEarn.
  ///
  /// In en, this message translates to:
  /// **'Check in to earn rewards'**
  String get checkinToEarn;

  /// No description provided for @checkinSuccess.
  ///
  /// In en, this message translates to:
  /// **'Check-in Success!'**
  String get checkinSuccess;

  /// No description provided for @alreadyCheckedin.
  ///
  /// In en, this message translates to:
  /// **'Already checked in today'**
  String get alreadyCheckedin;

  /// No description provided for @consecutiveCheckin.
  ///
  /// In en, this message translates to:
  /// **'Check-in streak: {days} days'**
  String consecutiveCheckin(int days);

  /// No description provided for @growthBadges.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get growthBadges;

  /// No description provided for @viewAchievements.
  ///
  /// In en, this message translates to:
  /// **'View your achievements'**
  String get viewAchievements;

  /// No description provided for @acceptRewards.
  ///
  /// In en, this message translates to:
  /// **'Got it!'**
  String get acceptRewards;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @addDetails.
  ///
  /// In en, this message translates to:
  /// **'Add details...'**
  String get addDetails;

  /// No description provided for @ruleNameDuplicate.
  ///
  /// In en, this message translates to:
  /// **'Name exists'**
  String get ruleNameDuplicate;

  /// No description provided for @logs.
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get logs;

  /// No description provided for @allLevels.
  ///
  /// In en, this message translates to:
  /// **'All Levels'**
  String get allLevels;

  /// No description provided for @noLogsFound.
  ///
  /// In en, this message translates to:
  /// **'No logs'**
  String get noLogsFound;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get noDescription;

  /// No description provided for @clearLogsTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Logs?'**
  String get clearLogsTitle;

  /// No description provided for @clearLogsMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete all logs. Permanent.'**
  String get clearLogsMessage;

  /// No description provided for @avatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get avatar;

  /// No description provided for @rewardImage.
  ///
  /// In en, this message translates to:
  /// **'Reward Image'**
  String get rewardImage;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @idiomGame.
  ///
  /// In en, this message translates to:
  /// **'Idiom Chain'**
  String get idiomGame;

  /// No description provided for @idiomGameDesc.
  ///
  /// In en, this message translates to:
  /// **'Challenge idiom chain game, expand vocabulary'**
  String get idiomGameDesc;

  /// No description provided for @yourTurn.
  ///
  /// In en, this message translates to:
  /// **'Your Turn'**
  String get yourTurn;

  /// No description provided for @aiTurn.
  ///
  /// In en, this message translates to:
  /// **'AI Turn'**
  String get aiTurn;

  /// No description provided for @chainLength.
  ///
  /// In en, this message translates to:
  /// **'Chain Length'**
  String get chainLength;

  /// No description provided for @starsEarned.
  ///
  /// In en, this message translates to:
  /// **'Stars Earned'**
  String get starsEarned;

  /// No description provided for @gameOver.
  ///
  /// In en, this message translates to:
  /// **'Game Over'**
  String get gameOver;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @failureNextTip.
  ///
  /// In en, this message translates to:
  /// **'Could have been:'**
  String get failureNextTip;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorTitle;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @errorDetails.
  ///
  /// In en, this message translates to:
  /// **'Error Details'**
  String get errorDetails;

  /// No description provided for @gameHall.
  ///
  /// In en, this message translates to:
  /// **'Game Hall'**
  String get gameHall;

  /// No description provided for @mainQuest.
  ///
  /// In en, this message translates to:
  /// **'Main Quest'**
  String get mainQuest;

  /// No description provided for @specialTraining.
  ///
  /// In en, this message translates to:
  /// **'Special Training'**
  String get specialTraining;

  /// No description provided for @idiomChainChallenge.
  ///
  /// In en, this message translates to:
  /// **'Idiom Chain Challenge'**
  String get idiomChainChallenge;

  /// No description provided for @idiomCompletion.
  ///
  /// In en, this message translates to:
  /// **'Idiom Completion'**
  String get idiomCompletion;

  /// No description provided for @completeMissingCharacters.
  ///
  /// In en, this message translates to:
  /// **'Complete missing characters'**
  String get completeMissingCharacters;

  /// No description provided for @guessIdiomByMeaning.
  ///
  /// In en, this message translates to:
  /// **'Guess by Meaning'**
  String get guessIdiomByMeaning;

  /// No description provided for @guessIdiomFromMeaning.
  ///
  /// In en, this message translates to:
  /// **'Guess idiom from meaning'**
  String get guessIdiomFromMeaning;

  /// No description provided for @myMistakeBook.
  ///
  /// In en, this message translates to:
  /// **'My Mistake Book'**
  String get myMistakeBook;

  /// No description provided for @reviewAndLearn.
  ///
  /// In en, this message translates to:
  /// **'Review and learn'**
  String get reviewAndLearn;

  /// No description provided for @ageYears.
  ///
  /// In en, this message translates to:
  /// **'{age} yrs'**
  String ageYears(int age);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

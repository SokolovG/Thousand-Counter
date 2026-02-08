import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

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
    Locale('ru'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Thousand Counter'**
  String get appTitle;

  /// Button to start a new game
  ///
  /// In en, this message translates to:
  /// **'Start Game'**
  String get startGame;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language settings title
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Label for language selection
  ///
  /// In en, this message translates to:
  /// **'Choose language:'**
  String get chooseLanguage;

  /// Rules dialog title
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get rules;

  /// Game label
  ///
  /// In en, this message translates to:
  /// **'Game'**
  String get game;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Save button label
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Hint text for player name input
  ///
  /// In en, this message translates to:
  /// **'Enter player name'**
  String get enterPlayerName;

  /// Title for player selection dialog
  ///
  /// In en, this message translates to:
  /// **'Who is playing?'**
  String get whoIsPlaying;

  /// Generic error message with placeholder
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorGeneric(Object error);

  /// Theme settings title
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Label for theme selection
  ///
  /// In en, this message translates to:
  /// **'Choose theme:'**
  String get chooseTheme;

  /// Title for player history dialog
  ///
  /// In en, this message translates to:
  /// **'Player game history:'**
  String get playerGameHistory;

  /// Title for game settings screen
  ///
  /// In en, this message translates to:
  /// **'Game settings'**
  String get gameSettings;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading profiles...'**
  String get loadingProfiles;

  /// Title for recent games section
  ///
  /// In en, this message translates to:
  /// **'Recent games'**
  String get recentGames;

  /// Message when no game is active
  ///
  /// In en, this message translates to:
  /// **'No active game'**
  String get noActiveGame;

  /// Round number label
  ///
  /// In en, this message translates to:
  /// **'Round {number}'**
  String round(Object number);

  /// Split points action
  ///
  /// In en, this message translates to:
  /// **'Split'**
  String get split;

  /// Button to confirm round scores
  ///
  /// In en, this message translates to:
  /// **'Confirm Round'**
  String get confirmRound;

  /// Title for profiles screen
  ///
  /// In en, this message translates to:
  /// **'Players profiles'**
  String get playersProfiles;

  /// Button to create a new game
  ///
  /// In en, this message translates to:
  /// **'Create new game'**
  String get createNewGame;

  /// Players section title
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get players;

  /// Default theme name
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultTheme;

  /// Sounds settings option
  ///
  /// In en, this message translates to:
  /// **'Sounds'**
  String get sounds;

  /// Game rules settings option
  ///
  /// In en, this message translates to:
  /// **'Game rules'**
  String get gameRules;

  /// Author settings option
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get author;

  /// Share app settings option
  ///
  /// In en, this message translates to:
  /// **'Share app'**
  String get shareApp;

  /// Version label
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Delete action label
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Title for adding a new player
  ///
  /// In en, this message translates to:
  /// **'Add new player'**
  String get addNewPlayer;

  /// Title for editing a player
  ///
  /// In en, this message translates to:
  /// **'Edit player'**
  String get editPlayer;

  /// Error message for minimum players
  ///
  /// In en, this message translates to:
  /// **'Minimum 2 players!'**
  String get minPlayersError;

  /// Error message for maximum players
  ///
  /// In en, this message translates to:
  /// **'Maximum 4 players!'**
  String get maxPlayersError;

  /// Total points display
  ///
  /// In en, this message translates to:
  /// **'Total: {points}'**
  String totalPoints(Object points);

  /// Bolts count display
  ///
  /// In en, this message translates to:
  /// **'B: {count}'**
  String bolts(Object count);

  /// Default name for a new game
  ///
  /// In en, this message translates to:
  /// **'Game from {date}'**
  String defaultGameName(Object date);

  /// Description of the game content
  ///
  /// In en, this message translates to:
  /// **'Game with players {players}'**
  String gameDescription(Object players);
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
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

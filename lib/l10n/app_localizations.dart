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

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

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

  /// The rules of the game
  ///
  /// In en, this message translates to:
  /// **'Rules of the card game \"1000\":\n\n1. Bolt\nIf a player takes no tricks during a round, they receive a \"bolt\" (displayed as a dash in the game results). If a player accumulates three bolts during the game, 120 points are deducted from their score, the bolts are annulled, and the procedure repeats if they get three bolts again.\n\n2. Bidding\nAfter cards are dealt, players evaluate their hands to determine how many points they can take. Then they declare their bids.\nA bid is a declaration of the number of points a player commits to taking in the current round.\nBidding starts immediately after dealing. The player with the first bid right is obligated to bid at least 100 points.\nPlayers then take turns bidding or passing (using the \"pass\" button). If a player passes, they cannot participate in further bidding for that round.\nBidding proceeds in increments of 5 points. The winner of the auction gets the first move and is obligated to take at least the declared amount of points during the round. If successful, the declared points are added to their score; otherwise, the sum is deducted.\nThe widow (priukup) is not revealed if there was no bidding war (i.e., someone bid the mandatory 100 and others passed). The player who won the bidding takes the widow and orders the game (declares the final bid).\n\n3. Bidding Constraints\nThere are rules limiting the points a player can bid:\n• A player cannot bid more than 120 points without a marriage in hand;\n• A player cannot bid more than 160 points with only a Spade marriage;\n• A player cannot bid more than 180 points with only a Club marriage;\n• A player cannot bid more than 200 points with only a Diamond marriage;\n• A player cannot bid more than 220 points with only a Heart marriage.\n\nIf possessing two or more marriages, the limit increases by the sum of their values.\n\n4. Gameplay\nThe winner of the auction leads first. Other players must follow suit (if void, play a trump; if void in trumps, play any card). The player with the highest card takes the trick and leads next. The player with the lead can declare a marriage.\nAt the end of the round, points are calculated: tricks plus declared marriages. If the auction winner made their contract, the points are added; if not, deducted. Other players receive the points they collected.\n\n5. Scoring\nPoints are counted based on card values. The sum is rounded to the nearest 5 (down for 2, up for 3).\nExample: 17 points = 15; 18 points = 20.\nThis rounding rule does not apply to the auction winner - if they are short even by 1 point from their bid, their score is not counted (contract failed).\nThe value of declared marriages is added to the points from tricks.\n\n6. \"Barrel\" Rules\nIf a player reaches 880 points, they sit on the \"barrel\".\nTo win, the player on the barrel must reach 1000 points (effectively taking 120 points). A marriage is not strictly required if the hand is a \"lay down\" (non-beatable) that collects all tricks (summing 120).\nThe player on the barrel has three attempts to reach the winning score. If they fail after three rounds, they fall off the barrel (score reduced by 120) and must climb back up (reach 880 again).\nOnly one player can be on the barrel at a time. If another player climbs onto the barrel, the first one falls off (penalty 120).'**
  String get rulesContent;
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

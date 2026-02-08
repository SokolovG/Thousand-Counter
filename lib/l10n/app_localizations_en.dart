// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Thousand Counter';

  @override
  String get startGame => 'Start Game';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose language:';

  @override
  String get rules => 'Rules';

  @override
  String get game => 'Game';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get enterPlayerName => 'Enter player name';

  @override
  String get whoIsPlaying => 'Who is playing?';

  @override
  String errorGeneric(Object error) {
    return 'Error: $error';
  }

  @override
  String get theme => 'Theme';

  @override
  String get chooseTheme => 'Choose theme:';

  @override
  String get playerGameHistory => 'Player game history:';

  @override
  String get gameSettings => 'Game settings';

  @override
  String get loadingProfiles => 'Loading profiles...';

  @override
  String get recentGames => 'Recent games';

  @override
  String get noActiveGame => 'No active game';

  @override
  String round(Object number) {
    return 'Round $number';
  }

  @override
  String get split => 'Split';

  @override
  String get confirmRound => 'Confirm Round';

  @override
  String get playersProfiles => 'Players profiles';

  @override
  String get createNewGame => 'Create new game';

  @override
  String get players => 'Players';

  @override
  String get defaultTheme => 'Default';

  @override
  String get sounds => 'Sounds';

  @override
  String get gameRules => 'Game rules';

  @override
  String get author => 'Author';

  @override
  String get shareApp => 'Share app';

  @override
  String get version => 'Version';

  @override
  String get delete => 'Delete';

  @override
  String get addNewPlayer => 'Add new player';

  @override
  String get editPlayer => 'Edit player';

  @override
  String get minPlayersError => 'Minimum 2 players!';

  @override
  String get maxPlayersError => 'Maximum 4 players!';

  @override
  String totalPoints(Object points) {
    return 'Total: $points';
  }

  @override
  String bolts(Object count) {
    return 'B: $count';
  }

  @override
  String defaultGameName(Object date) {
    return 'Game from $date';
  }

  @override
  String gameDescription(Object players) {
    return 'Game with players $players';
  }
}

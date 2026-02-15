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
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

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
    return 'Current round: $number';
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
  String get authorName => 'Grigoriy Sokolov';

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
  String get minPlayersError => 'Game must have at least 3 players';

  @override
  String get maxPlayersError => 'Game cannot have more than 4 players';

  @override
  String get emptyNameError => 'Player name cannot be empty';

  @override
  String get nameTooLongError => 'Player name too long';

  @override
  String get invalidNameError => 'Name can only contain letters';

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

  @override
  String get rulesContent =>
      'Rules of the card game \"Thousand\":\n\n1. Bolt\nIf a player takes no tricks during a round, they receive a \"bolt\" (displayed as a dash in the game results). If a player accumulates three bolts during the game, 120 points are deducted from their score, the bolts are annulled, and the procedure repeats if they get three bolts again.\n\n2. Bidding\nAfter cards are dealt, players evaluate their hands to determine how many points they can take. Then they declare their bids.\nA bid is a declaration of the number of points a player commits to taking in the current round.\nBidding starts immediately after dealing. The player with the first bid right is obligated to bid at least 100 points.\nPlayers then take turns bidding or passing (using the \"pass\" button). If a player passes, they cannot participate in further bidding for that round.\nBidding proceeds in increments of 5 points. The winner of the auction gets the first move and is obligated to take at least the declared amount of points during the round. If successful, the declared points are added to their score; otherwise, the sum is deducted.\nThe widow (priukup) is not revealed if there was no bidding war (i.e., someone bid the mandatory 100 and others passed). The player who won the bidding takes the widow and orders the game (declares the final bid).\n\n3. Bidding Constraints\nThere are rules limiting the points a player can bid:\n• A player cannot bid more than 120 points without a marriage in hand;\n• A player cannot bid more than 160 points with only a Spade marriage;\n• A player cannot bid more than 180 points with only a Club marriage;\n• A player cannot bid more than 200 points with only a Diamond marriage;\n• A player cannot bid more than 220 points with only a Heart marriage.\n\nIf possessing two or more marriages, the limit increases by the sum of their values.\n\n4. Gameplay\nThe winner of the auction leads first. Other players must follow suit (if void, play a trump; if void in trumps, play any card). The player with the highest card takes the trick and leads next. The player with the lead can declare a marriage.\nAt the end of the round, points are calculated: tricks plus declared marriages. If the auction winner made their contract, the points are added; if not, deducted. Other players receive the points they collected.\n\n5. Scoring\nPoints are counted based on card values. The sum is rounded to the nearest 5 (down for 2, up for 3).\nExample: 17 points = 15; 18 points = 20.\nThis rounding rule does not apply to the auction winner - if they are short even by 1 point from their bid, their score is not counted (contract failed).\nThe value of declared marriages is added to the points from tricks.\n\n6. \"Barrel\" Rules\nIf a player reaches 880 points, they sit on the \"barrel\".\nTo win, the player on the barrel must reach 1000 points (effectively taking 120 points). A marriage is not strictly required if the hand is a \"lay down\" (non-beatable) that collects all tricks (summing 120).\nThe player on the barrel has three attempts to reach the winning score. If they fail after three rounds, they fall off the barrel (score reduced by 120) and must climb back up (reach 880 again).\nOnly one player can be on the barrel at a time. If another player climbs onto the barrel, the first one falls off (penalty 120).';

  @override
  String get sourceCode => 'Source code';

  @override
  String get roundsHistory => 'Rounds history';

  @override
  String get emptyRoundsHistory =>
      'The history is still empty.\nPlay the first round!';

  @override
  String roundNumber(Object roundNumber) {
    return 'Round $roundNumber';
  }

  @override
  String get editRound => 'Edit';

  @override
  String get deleteRound => 'Delete';

  @override
  String get liveStatus => 'Live status:';

  @override
  String get generalStatistics => 'General statistics:';

  @override
  String get errorGameNotFound => 'Game not found';

  @override
  String get databaseDelete => 'Are you sure you want to clear the database?';

  @override
  String get confirm => 'Confrim';

  @override
  String get clearDatabase => 'Clear the database';

  @override
  String get databaseView => 'View database';

  @override
  String get loadingGame => 'Loading game...';

  @override
  String get addProfiles =>
      'You don\'t have any player profiles yet... it\'s time to add some friends';

  @override
  String get playGame =>
      'You don\'t have any past games yet... Play your first game now!';

  @override
  String get loadingGames => 'Loading games...';
}

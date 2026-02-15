import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';

class GameValidators {
  static void validatePlayerCount(int count, AppLocalizations l10n) {
    if (count < minPlayers) {
      throw ArgumentError(l10n.minPlayersError);
    }
    if (count > maxPlayers) {
      throw ArgumentError(l10n.maxPlayersError);
    }
  }

  static bool canAddMorePlayers(int count) => count < maxPlayers;
  static bool canStartGame(int count) =>
      count >= minPlayers && count <= maxPlayers;
}

class ProfileValidators {
  static void validateProfileName(String name, AppLocalizations l10n) {
    if (name.isEmpty) {
      throw ArgumentError(l10n.emptyNameError);
    }
    if (name.length > maxNameLength) {
      throw ArgumentError(l10n.nameTooLongError);
    }

    if (name.contains(RegExp(r'[^\p{L} ]', unicode: true))) {
      throw ArgumentError(l10n.invalidNameError);
    }
  }
}

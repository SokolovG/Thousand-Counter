import 'package:thousand_counter/core/constants.dart';

class GameValidators {
  static void validatePlayerCount(int count) {
    if (count < minPlayers) {
      throw ArgumentError("Game must have at least 3 players");
    }
    if (count > maxPlayers) {
      throw ArgumentError("Game cannot have more than 4 players");
    }
  }

  static bool canAddMorePlayers(int count) => count < maxPlayers;
  static bool canStartGame(int count) =>
      count >= minPlayers && count <= maxPlayers;
}

class ProfileValidators {
  static void validateProfileName(String name) {
    if (name.isEmpty) {
      throw ArgumentError("Player name cannot be empty");
    }
    if (name.length > maxNameLength) {
      throw ArgumentError("Player name too long");
    }

    if (name.contains(RegExp(r'[^\p{L} ]', unicode: true))) {
      throw ArgumentError("Имя может содержать только буквы");
    }
  }
}

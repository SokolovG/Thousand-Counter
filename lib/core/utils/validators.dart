class GameValidators {
  static void validatePlayerCount(int count) {
    if (count < 2) {
      throw ArgumentError("Game must have at least 2 players");
    }
    if (count > 4) {
      throw ArgumentError("Game cannot have more than 4 players");
    }
  }

  static bool canAddMorePlayers(int count) => count < 4;
  static bool canStartGame(int count) => count >= 2 && count <= 4;
}

class ProfileValidators {
  static void validateProfileName(String name) {
    if (name.isEmpty) {
      throw ArgumentError("Player name cannot be empty");
    }
    if (name.length > 30) {
      throw ArgumentError("Player name too long");
    }

    if (name.contains(RegExp(r'[^a-zA-Z ]'))) {
      //TODO: add smart check - only check is special symbold in string
      throw ArgumentError("Player name cant contain special symbols");
    }
  }
}

class GameValidators {
  static void validatePlayerCount(int count) {
    if (count < 2) {
      throw ArgumentError("Game must have at least 2 players");
    }
    if (count > 4) {
      throw ArgumentError("Game cannot have more than 4 players");
    }
  }

  static void validatePlayerName(String name) {
    if (name.isEmpty) {
      throw ArgumentError("Player name cannot be empty");
    }
    if (name.length > 30) {
      throw ArgumentError("Player name too long");
    }
  }
}

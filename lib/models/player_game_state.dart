class PlayerGameState {
  final String playerId;
  int totalPoints;
  int boltsCount;

  PlayerGameState({
    required this.playerId,
    this.totalPoints = 0,
    this.boltsCount = 0,
  });
}

class Round {
  final int roundNumber;
  final Map<String, int> playerScores;

  Round({required this.roundNumber, required this.playerScores});

  @override
  String toString() {
    return "Round number $roundNumber";
  }
}

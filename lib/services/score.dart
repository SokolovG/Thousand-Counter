class ScoreService {
  int calculateRoundScore(int basePoints, bool isBolt, bool isMagic) {
    if (isBolt) return 0;
    return basePoints;
  }
}

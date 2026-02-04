class ScoreService {
  int calculateRoundScore(
    int basePoints,
    bool isBolt,
    bool isMagic,
    int currentTotal,
    int boltsCount,
  ) {
    if (isMagic) {
      return 0;
    }

    if (isBolt) {
      if (boltsCount + 1 == 3) {
        return currentTotal - 120;
      }
      return currentTotal;
    }

    return currentTotal + basePoints;
  }
}

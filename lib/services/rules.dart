import '../core/constants.dart';
import '../models/player.dart';

class RulesService {
  bool isBolt(int points, bool isOnBarrel) => points == 0 && !isOnBarrel;

  bool isBarrel(int totalPoints) => totalPoints >= barrelNumber;

  bool isMagicNumber(int points) =>
      points == negativeKillNumber || points == positiveKillNumber;

  bool hasThreeBoltsFromPlayer(Player player) =>
      player.boltsCount >= maxBoltsNumber;
  bool hasThreeBoltsFromInt(int count) => count >= maxBoltsNumber;
}

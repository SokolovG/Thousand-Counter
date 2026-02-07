import '../core/constants.dart';
import '../models/player.dart';

class RulesService {
  bool isBolt(int points) => points == 0;

  bool isBarrel(int totalPoints) => totalPoints >= barrelNumber;

  bool hasThreeBarrelsFromPlayer(Player player) =>
      player.barrelCount >= maxBarrelsNumber;
  bool hasThreeBarrelsFromInt(int count) => count >= maxBarrelsNumber;

  bool isMagicNumber(int points) =>
      points == negativeKillNumber || points == positiveKillNumber;

  bool hasThreeBoltsFromPlayer(Player player) =>
      player.boltsCount >= maxBoltsNumber;
  bool hasThreeBoltsFromInt(int count) => count >= maxBoltsNumber;
}

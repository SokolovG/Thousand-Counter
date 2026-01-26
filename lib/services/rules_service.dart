import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/models/player.dart';

class RulesService {
  bool isBolt(int points) => points == 0;

  bool isBarrel(int totalPoints) => totalPoints == barrelNumber;

  bool isMagicNumber(int points) =>
      points == negativeKillNumber || points == positiveKillNumber;

  bool hasThreeBolts(Player player) => player.boltsCount >= maxBoltsNumber;
}

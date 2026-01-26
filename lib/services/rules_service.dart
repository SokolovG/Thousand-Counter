import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/models/round.dart';

class RulesService {
  bool checkBolt(Round round, String playerId) {
    return round.playerScores[playerId] == 0;
  }

  bool checkBarrel(Player player) {
    if (player.totalPoints == barrelNumber) {
      return true;
    }
    return false;
  }

  bool checkMagicalNumbers(int points) {
    if (points == negativeKillNumber || points == positiveKillNumber) {
      return true;
    }
    return false;
  }

  bool check3Bolts(Player player) {
    if (player.boltsCount == maxBoltsNumber) {
      // maybe here set bolts to 0?
      return true;
    }
    return false;
  }
}

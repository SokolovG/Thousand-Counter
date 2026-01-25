import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/models/player.dart';

class RulesService {
  bool checkBolt(Player player) {
    // if user points in round == 0 -> bolt
    return true;
  }

  bool checkBarrel(Player player) {
    // if user points in round == 0 -> bolt
    return true;
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

import '../core/constants.dart';
import '../models/player_game_state.dart';

class RulesService {
  bool isBolt(int points) => points == 0;

  bool isBarrel(int totalPoints) => totalPoints == barrelNumber;

  bool isMagicNumber(int points) =>
      points == negativeKillNumber || points == positiveKillNumber;

  bool hasThreeBolts(PlayerGameState player) =>
      player.boltsCount >= maxBoltsNumber;
}

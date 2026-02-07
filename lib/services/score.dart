import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/services/rules.dart';

class ScoreService {
  final RulesService _rulesService;
  ScoreService(this._rulesService);

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
      if (_rulesService.hasThreeBoltsFromInt(boltsCount + 1)) {
        return currentTotal - barrelPenalty;
      }
      return currentTotal;
    }

    return currentTotal + basePoints;
  }
}

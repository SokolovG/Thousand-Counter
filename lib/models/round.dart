import 'package:thousand_counter/core/enums.dart';
import 'package:thousand_counter/data/local/database.dart';
import 'package:thousand_counter/models/base_model.dart';

class Round extends Entity {
  final int roundNumber;
  final String gameId;
  final Map<String, int> playerScores;
  final Map<String, List<SpecialGameEvent>> specialEvents;

  Round({
    required this.roundNumber,
    required this.playerScores,
    required this.specialEvents,
    required this.gameId,
  });

  factory Round.fromDb(RoundModel model) {
    return Round(
      roundNumber: model.roundNumber,
      playerScores: model.playerScores,
      specialEvents: model.specialEvents,
      gameId: model.gameId,
    );
  }

  @override
  String toString() {
    return "Round number $roundNumber";
  }
}

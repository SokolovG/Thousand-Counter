import 'package:thousand_counter/core/enums.dart';

class Round {
  final int roundNumber;
  final Map<String, int> playerScores;
  final Map<String, List<SpecialGameEvent>> specialEvents;

  Round({
    required this.roundNumber,
    required this.playerScores,
    required this.specialEvents,
  });

  @override
  String toString() {
    return "Round number $roundNumber";
  }
}

import 'package:thousand_counter/models/player_game_state.dart';
import 'package:recase/recase.dart';

import 'round.dart';
import 'package:uuid/uuid.dart';

class Game {
  List<PlayerGameState> playerStates;
  final List<Round> rounds;
  final DateTime createdAt;
  final String id;
  int currentRound;

  Game({required this.playerStates})
    : rounds = [],
      id = Uuid().v4(),
      currentRound = 0,
      createdAt = DateTime.now();

  @override
  String toString() {
    final playerNames = playerStates
        .map((p) => p.profile.name.sentenceCase)
        .join(', ');
    return "Game with players $playerNames";
  }
}

import 'package:thousand_counter/models/player_game_state.dart';
import 'package:thousand_counter/models/player_profile.dart';

import 'round.dart';
import 'package:uuid/uuid.dart';

class Game {
  List<PlayerGameState> playerStates;
  final List<PlayerProfile> profiles;
  final List<Round> rounds;
  final DateTime createdAt;
  final String id;
  int currentRound;

  Game({required this.playerStates, required this.profiles})
    : rounds = [],
      id = Uuid().v4(),
      currentRound = 0,
      createdAt = DateTime.now();

  @override
  String toString() {
    return "Game with players $profiles";
  }
}

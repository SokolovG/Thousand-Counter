import 'player.dart';
import 'round.dart';
import 'package:uuid/uuid.dart';

class Game {
  final List<Player> players;
  final List<Round> rounds;
  final DateTime createdAt;
  final String id;
  int currentRound;

  Game({required this.players})
    : rounds = [],
      id = Uuid().v4(),
      currentRound = 0,
      createdAt = DateTime.now();

  @override
  String toString() {
    return "Game with players $players";
  }
}

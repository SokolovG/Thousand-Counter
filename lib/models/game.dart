import 'player.dart';
import 'package:recase/recase.dart';

import 'round.dart';
import 'package:uuid/uuid.dart';

class Game {
  List<Player> players;
  final List<Round> rounds;
  final DateTime createdAt;
  final String id;
  int currentRound;
  bool isFinished = false;

  Game({
    required this.players,
    List<Round>? rounds,
    String? id,
    DateTime? createdAt,
    this.currentRound = 0,
    this.isFinished = false,
  }) : rounds = rounds ?? [],
       id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  @override
  String toString() {
    final playerNames = players
        .map((p) => p.profile.name.sentenceCase)
        .join(', ');
    return "Game with players $playerNames";
  }

  Game copyWith({
    List<Player>? players,
    List<Round>? rounds,
    int? currentRound,
    bool? isFinished,
  }) {
    return Game(
      players: players ?? this.players,
      rounds: rounds ?? this.rounds,
      id: id,
      createdAt: createdAt,
      currentRound: currentRound ?? this.currentRound,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}

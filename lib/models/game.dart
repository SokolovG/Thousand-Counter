import 'package:thousand_counter/models/base_model.dart';
import 'player.dart';
import 'package:recase/recase.dart';
import 'round.dart';

class Game extends Entity {
  List<Player> players;
  final List<Round> rounds;
  final DateTime createdAt;
  final int currentRound;
  final bool isFinished;

  Game({
    super.id,
    required this.players,
    List<Round>? rounds,
    DateTime? createdAt,
    this.currentRound = 1,
    this.isFinished = false,
  }) : rounds = rounds ?? [],
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

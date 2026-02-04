import 'package:thousand_counter/models/base_model.dart';
import 'player.dart';
import 'package:recase/recase.dart';
import 'round.dart';

class Game extends Entity {
  final List<Player> players;
  final List<Round> rounds;
  final DateTime createdAt;
  final int currentRound;
  final bool isFinished;
  final String name;

  Game({
    super.id,
    required this.players,
    List<Round>? rounds,
    DateTime? createdAt,
    this.currentRound = 1,
    this.isFinished = false,
    String? name,
  }) : rounds = rounds ?? [],
       createdAt = createdAt ?? DateTime.now(),
       name = name ?? "Game from ${DateTime.now().day}.${DateTime.now().month}";

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
    String? name,
  }) {
    return Game(
      players: players ?? this.players,
      rounds: rounds ?? this.rounds,
      id: id,
      createdAt: createdAt,
      currentRound: currentRound ?? this.currentRound,
      isFinished: isFinished ?? this.isFinished,
      name: name ?? this.name,
    );
  }
}

import 'package:thousand_counter/models/base_model.dart';
import 'player.dart';
import 'round.dart';

class Game extends Entity {
  final List<Player> players;
  final List<Round> rounds;
  final DateTime createdAt;
  final int currentRound;
  final bool isFinished;
  final String name;
  final Player? winner;
  final int currentPlayerIndex;

  Game({
    super.id,
    required this.players,
    List<Round>? rounds,
    DateTime? createdAt,
    this.currentRound = 1,
    this.isFinished = false,
    String? name,
    this.winner,
    this.currentPlayerIndex = 0,
  }) : rounds = rounds ?? [],
       createdAt = createdAt ?? DateTime.now(),
       name = name ?? "";

  @override
  @override
  String toString() {
    return "Game(id: $id, players: ${players.length})"; 
  }

  Game copyWith({
    List<Player>? players,
    List<Round>? rounds,
    int? currentRound,
    bool? isFinished,
    String? name,
    Player? winner,
    int currentPlayerIndex = 0,
  }) {
    return Game(
      players: players ?? this.players,
      rounds: rounds ?? this.rounds,
      id: id,
      createdAt: createdAt,
      currentRound: currentRound ?? this.currentRound,
      isFinished: isFinished ?? this.isFinished,
      name: name ?? this.name,
      winner: winner ?? this.winner,
      currentPlayerIndex: currentPlayerIndex,
    );
  }
}

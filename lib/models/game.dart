import 'package:thousand_counter/core/enums.dart';
import 'package:thousand_counter/models/base_model.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/models/player_stats.dart';
import 'package:thousand_counter/models/round.dart';

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

extension GameStats on Game {
  PlayerStats getStatsForPlayer(String playerId) {
    final player = players.firstWhere((p) => p.profile.id == playerId);
    return rounds.fold<PlayerStats>(
      PlayerStats(
        currentBolts: player.boltsCount,
        currentBarrels: player.barrelAttempts,
        totalBolts: 0,
        totalBarrels: 0,
        totalMagicNumbers: 0,
        wasOnBarrel: false,
      ),
      (stats, round) {
        final events = round.specialEvents[playerId] ?? [];
        final hasBarrelIcon =
            round.specialEvents[playerId]?.contains(SpecialGameEvent.barrel) ??
            false;
        bool usedAttempt = stats.wasOnBarrel;

        return PlayerStats(
          currentBolts: stats.currentBolts,
          currentBarrels: stats.currentBarrels,
          wasOnBarrel: hasBarrelIcon,
          totalBolts:
              stats.totalBolts +
              (events.contains(SpecialGameEvent.bolt) ? 1 : 0),
          totalBarrels: stats.totalBarrels + (usedAttempt ? 1 : 0),
          totalMagicNumbers:
              stats.totalMagicNumbers +
              (events.contains(SpecialGameEvent.magicNumber) ? 1 : 0),
        );
      },
    );
  }
}

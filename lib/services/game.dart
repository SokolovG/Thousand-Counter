import 'package:talker_flutter/talker_flutter.dart';
import 'package:thousand_counter/models/profile.dart';

import '../core/constants.dart';
import '../core/utils/validators.dart';
import '../models/game.dart';
import '../models/player.dart';
import '../models/round.dart';
import 'rules.dart';
import 'score.dart';

class GameService {
  // ignore: unused_field
  final Talker _talker;
  final RulesService _rulesService;
  final ScoreService _scoreService;

  GameService(this._rulesService, this._scoreService, this._talker);

  void addRound(Game game, Map<String, int> points) {
    final round = Round(roundNumber: game.currentRound, playerScores: points);
    game.rounds.add(round);

    points.forEach((playerId, basePoints) {
      final player = game.players.firstWhere((p) => p.profile.id == playerId);
      final isBolt = _rulesService.isBolt(basePoints);
      final isMagic = _rulesService.isMagicNumber(basePoints);

      if (isBolt) {
        player.boltsCount++;
      }
      final score = _scoreService.calculateRoundScore(
        basePoints,
        isBolt,
        isMagic,
      );

      player.totalPoints += score;
    });
    game.currentRound++;
  }

  Game updatePlayers(Game currentGame, List<Profile> newProfiles) {
    if (!GameValidators.canAddMorePlayers(newProfiles.length)) {
      return currentGame;
    }

    final List<Player> updatedPlayers = newProfiles.map((profile) {
      final existingPlayer = currentGame.players.firstWhere(
        (p) => p.profile.id == profile.id,
        orElse: () => Player(profile: profile),
      );
      return existingPlayer;
    }).toList();

    return currentGame.copyWith(players: updatedPlayers);
  }

  void addPlayer(Game game, Player player) {
    if (game.players.length >= maxPlayers) {
      throw Exception("Max $maxPlayers players");
    }
    game.players.add(player);
  }

  Game startGame(List<Profile> profiles) {
    // _talker.debug("Starting game with ${profiles.length} profiles");
    GameValidators.validatePlayerCount(profiles.length);
    final players = profiles
        .map((profile) => Player(profile: profile))
        .toList();
    final game = Game(players: players);
    // _talker.info("Game created successfully: $game");
    return game;
  }

  Player? getWinner(Game game) {
    final qualifiedPlayers = game.players
        .where((p) => p.totalPoints >= 1000)
        .toList();

    if (qualifiedPlayers.isEmpty) return null;

    qualifiedPlayers.sort((a, b) => b.totalPoints.compareTo(a.totalPoints));
    return qualifiedPlayers.first;
  }
}

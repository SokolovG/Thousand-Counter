import 'package:talker_flutter/talker_flutter.dart';
import 'package:thousand_counter/data/repositories/game.dart';
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
  final GameRepository _gameRepository;

  GameService(
    this._rulesService,
    this._scoreService,
    this._talker,
    this._gameRepository,
  );

  Future<List<Game>> getAllGames() async {
    final games = await _gameRepository.getAll();
    return games;
  }

  Game confirmRound(Game game, Map<String, int> points) {
    List<Player> updatedPlayers = game.players.map((p) {
      final scoreToAdd = points[p.profile.id] ?? 0;
      final isBolt = _rulesService.isBolt(scoreToAdd);
      final isMagic = _rulesService.isMagicNumber(scoreToAdd);
      isBolt ? p.boltsCount + 1 : null;
      final isThreeBolts = _rulesService.hasThreeBoltsFromPlayer(p);
      final isThreeBarrels = _rulesService.hasThreeBarrelsFromPlayer(p);
      int totalPlayerPoints = _scoreService.calculateRoundScore(
        scoreToAdd,
        isBolt,
        isMagic,
        p.totalPoints,
        p.boltsCount,
      );

      return p.copyWith(
        totalPoints: totalPlayerPoints,
        boltsCount: isThreeBolts ? 0 : p.boltsCount,
        barrelsCount: isThreeBarrels ? 0 : p.barrelCount,
      );
    }).toList();

    Round newRound = Round(
      roundNumber: game.rounds.length + 1,
      playerScores: points,
    );
    return game.copyWith(
      players: updatedPlayers,
      rounds: [...game.rounds, newRound],
      currentRound: game.currentRound + 1,
    );
  }

  Future<Game> addGame(Game game) async {
    game = await _gameRepository.add(game);
    return game;
  }

  Game addBolt(String profileId, Game game) {
    final updatedPlayers = game.players.map((player) {
      if (player.profile.id == profileId) {
        return player.copyWith(boltsCount: player.boltsCount + 1);
      }
      return player;
    }).toList();

    return game.copyWith(players: updatedPlayers);
  }

  Game updatePlayers(Game currentGame, List<Profile> newProfiles) {
    // if (!GameValidators.canAddMorePlayers(newProfiles.length)) {
    //   return currentGame;
    // }
    if (newProfiles.length > 4) {
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
        .where((p) => p.totalPoints >= maxPoints)
        .toList();

    if (qualifiedPlayers.isEmpty) return null;

    qualifiedPlayers.sort((a, b) => b.totalPoints.compareTo(a.totalPoints));
    return qualifiedPlayers.first;
  }
}

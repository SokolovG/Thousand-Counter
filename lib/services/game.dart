import 'package:talker_flutter/talker_flutter.dart';
import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/core/enums.dart';
import 'package:thousand_counter/core/utils/validators.dart';
import 'package:thousand_counter/data/repositories/game.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/models/round.dart';
import 'package:thousand_counter/services/rules.dart';

class GameService {
  // ignore: unused_field
  final Talker _talker;
  final RulesService _rulesService;
  final GameRepository _gameRepository;

  GameService(this._rulesService, this._talker, this._gameRepository);

  Future<List<Game>> getAllGames() async {
    final games = await _gameRepository.getAll();
    return games;
  }

  Future<Game?> getGameById(String id) async {
    final Game? game = await _gameRepository.get(id);
    return game;
  }

  Game deleteRound(Game game) {
    return game;
  }

  Game updateRound(Game game) {
    return game;
  }

  Game split(Game game, int bid, int bidderIndex) {
    final updatedPlayers = List<Player>.from(game.players);
    final activePlayer = updatedPlayers[bidderIndex];
    Map<String, int> roundResultsForHistory = {};
    Map<String, List<SpecialGameEvent>> gameEventsMap = {};

    int activePlayerPoints = activePlayer.totalPoints;
    int activePlayerAttempts = activePlayer.barrelAttempts;
    bool activePlayerOnBarrel = activePlayer.isOnBarrel;

    if (activePlayerOnBarrel) {
      gameEventsMap[activePlayer.profile.id] = [SpecialGameEvent.barrelFall];
      activePlayerAttempts += 1;

      if (activePlayerAttempts >= maxBarrelsNumber) {
        activePlayerOnBarrel = false;
        activePlayerAttempts = 0;
        activePlayerPoints = barrelNumber - barrelPenalty;
      } else {
        activePlayerPoints = activePlayer.totalPoints;
      }
    } else {
      activePlayerPoints = activePlayer.totalPoints - bid;
    }

    updatedPlayers[bidderIndex] = activePlayer.copyWith(
      totalPoints: activePlayerPoints,
      barrelAttempts: activePlayerAttempts,
      isOnBarrel: activePlayerOnBarrel,
    );

    final pointsToOthers = (bid / 2).round();

    int dealerIndex = (game.currentPlayerIndex - 1) % updatedPlayers.length;
    if (dealerIndex < 0) dealerIndex = updatedPlayers.length - 1;

    for (int i = 0; i < updatedPlayers.length; i++) {
      int pPoints = updatedPlayers[i].totalPoints;
      bool pOnBarrel = updatedPlayers[i].isOnBarrel;
      int pAttempts = updatedPlayers[i].barrelAttempts;
      List<SpecialGameEvent> pEvents = [];

      if (i == bidderIndex) continue;
      if (updatedPlayers.length == maxPlayers && i == dealerIndex) continue;

      if (pOnBarrel) {
        pAttempts += 1;
        if (pAttempts >= maxBarrelsNumber) {
          pOnBarrel = false;
          pAttempts = 0;
          pPoints = barrelNumber - barrelPenalty;
          pEvents.add(SpecialGameEvent.barrelFall);
        } else {
          pEvents.add(SpecialGameEvent.barrel);
          pPoints = updatedPlayers[i].totalPoints;
        }
      } else {
        pPoints = pPoints + pointsToOthers;
      }

      int pureDelta = pOnBarrel ? 0 : pointsToOthers;
      roundResultsForHistory[updatedPlayers[i].profile.id] = pureDelta;

      if (pEvents.isNotEmpty) {
        gameEventsMap[updatedPlayers[i].profile.id] = pEvents;
      }

      final isMagic = _rulesService.isMagicNumber(pPoints);
      if (isMagic) pEvents.add(SpecialGameEvent.magicNumber);

      updatedPlayers[i] = updatedPlayers[i].copyWith(
        totalPoints: isMagic ? 0 : pPoints,
        barrelAttempts: pAttempts,
        isOnBarrel: pOnBarrel,
      );
    }
    roundResultsForHistory[activePlayer.profile.id] =
        roundResultsForHistory[activePlayer.profile.id] = -bid;

    Round newRound = Round(
      roundNumber: game.rounds.length + 1,
      playerScores: roundResultsForHistory,
      specialEvents: gameEventsMap,
    );

    return game.copyWith(
      rounds: [...game.rounds, newRound],
      players: updatedPlayers,
      currentRound: game.currentRound + 1,
      currentPlayerIndex: (game.currentPlayerIndex + 1) % game.players.length,
    );
  }

  Game confirmRound({
    required Game game,
    required Map<String, int> points,
    required String bidderId,
    required int bid,
  }) {
    final processedPoints = Map<String, int>.from(points);
    final bidderScore = processedPoints[bidderId] ?? 0;
    Map<String, int> roundResultsForHistory = {};
    Map<String, List<SpecialGameEvent>> gameEventsMap = {};

    if (bidderScore < bid) {
      processedPoints[bidderId] = -bid;
    }

    Player? newBarrelPlayer = game.players.where((p) {
      final scoreToAdd = processedPoints[p.profile.id] ?? 0;
      final newTotal = p.totalPoints + scoreToAdd;
      return newTotal >= barrelNumber && !p.isOnBarrel;
    }).firstOrNull;

    List<Player> updatedPlayers = game.players.map((p) {
      final scoreToAdd = processedPoints[p.profile.id] ?? 0;
      final newTotal = p.totalPoints + scoreToAdd;

      List<SpecialGameEvent> pEvents = [];

      bool newIsOnBarrel = p.isOnBarrel;
      int newBarrelAttempts = p.barrelAttempts;
      int newTotalPoints = p.totalPoints;

      if (p.isOnBarrel) {
        if (newTotal >= maxPoints) {
          // WIN
          newTotalPoints = newTotal;
          newIsOnBarrel = false;
          newBarrelAttempts = 0;
        } else if (newBarrelPlayer != null &&
            newBarrelPlayer.profile.id != p.profile.id) {
          pEvents.add(SpecialGameEvent.barrelFall);
          newIsOnBarrel = false;
          newBarrelAttempts = 0;
          newTotalPoints = barrelNumber - barrelPenalty;
        } else {
          newBarrelAttempts = p.barrelAttempts + 1;
          if (newBarrelAttempts >= maxBarrelsNumber) {
            pEvents.add(SpecialGameEvent.barrelFall);
            newIsOnBarrel = false;
            newBarrelAttempts = 0;
            newTotalPoints = barrelNumber - barrelPenalty;
          } else {
            pEvents.add(SpecialGameEvent.barrel);
            newTotalPoints = barrelNumber;
          }
        }
      } else if (newTotal >= barrelNumber) {
        pEvents.add(SpecialGameEvent.barrel);
        newIsOnBarrel = true;
        newBarrelAttempts = 0;
        newTotalPoints = barrelNumber;
      } else {
        newTotalPoints = newTotal;
      }

      final isBolt = _rulesService.isBolt(scoreToAdd, p.isOnBarrel);
      if (isBolt && !p.isOnBarrel) pEvents.add(SpecialGameEvent.bolt);

      int newBoltsCount = isBolt ? p.boltsCount + 1 : p.boltsCount;
      final isMagic = _rulesService.isMagicNumber(newTotalPoints);
      if (isMagic) pEvents.add(SpecialGameEvent.magicNumber);

      final isThreeBolts = _rulesService.hasThreeBoltsFromInt(newBoltsCount);

      int pureDelta = scoreToAdd;

      if (isBolt && isThreeBolts) {
        newTotalPoints -= boltPenalty;
        newBoltsCount = 0;
        pureDelta -= boltPenalty;
      }

      if (pEvents.isNotEmpty) {
        gameEventsMap[p.profile.id] = pEvents;
      }
      roundResultsForHistory[p.profile.id] = pureDelta;

      return p.copyWith(
        totalPoints: isMagic ? 0 : newTotalPoints,
        isOnBarrel: newIsOnBarrel,
        barrelAttempts: newBarrelAttempts,
        boltsCount: newBoltsCount,
      );
    }).toList();

    Round newRound = Round(
      roundNumber: game.rounds.length + 1,
      playerScores: roundResultsForHistory,
      specialEvents: gameEventsMap,
    );

    game = game.copyWith(
      players: updatedPlayers,
      rounds: [...game.rounds, newRound],
      currentRound: game.currentRound + 1,
      currentPlayerIndex: (game.currentPlayerIndex + 1) % game.players.length,
    );

    Player? winner = getWinner(game);
    if (winner != null) {
      game = game.copyWith(winner: winner, isFinished: true);
    }

    _gameRepository.update(game);
    return game;
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
    if (newProfiles.length > maxPlayers) {
      return currentGame;
    }

    final String activeId =
        currentGame.players[currentGame.currentPlayerIndex].profile.id;

    final List<Player> updatedPlayers = newProfiles.map((profile) {
      return currentGame.players.firstWhere(
        (p) => p.profile.id == profile.id,
        orElse: () => Player(profile: profile),
      );
    }).toList();

    int newIndex = updatedPlayers.indexWhere((p) => p.profile.id == activeId);

    if (newIndex == -1) {
      newIndex = currentGame.currentPlayerIndex % updatedPlayers.length;
    }

    return currentGame.copyWith(
      players: updatedPlayers,
      currentPlayerIndex: newIndex,
    );
  }

  void addPlayer(Game currentGame, Player player) {
    if (currentGame.players.length > maxPlayers) {
      throw Exception("Max $maxPlayers players");
    }
    currentGame.copyWith(players: [...currentGame.players, player]);
  }

  Game startGame(List<Profile> profiles, {String? name}) {
    // _talker.debug("Starting game with ${profiles.length} profiles");
    GameValidators.validatePlayerCount(profiles.length);
    final players = profiles
        .map((profile) => Player(profile: profile))
        .toList();
    final game = Game(players: players, name: name);
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

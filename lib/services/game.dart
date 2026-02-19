import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/core/enums.dart';
import 'package:thousand_counter/core/utils/validators.dart';
import 'package:thousand_counter/data/repositories/game.dart';
import 'package:thousand_counter/data/repositories/rounds.dart';
import 'package:thousand_counter/data/uow/game.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/models/round.dart';
import 'package:thousand_counter/services/rules.dart';

class GameService {
  final RulesService _rulesService;
  final GameRepository _gameRepository;
  final RoundsRepository _roundRepository;
  final GameUnitOfWork _gameUow;

  GameService(
    this._rulesService,
    this._gameRepository,
    this._roundRepository,
    this._gameUow,
  );

  Future<List<Game>> getAllGames() async {
    final games = await _gameRepository.getAll();
    return games;
  }

  Stream<Game?> watchGame(String id) {
    final Stream<Game?> game = _gameRepository.get(id).asyncMap((game) async {
      if (game == null) return null;
      final rounds = await _roundRepository.getAllByGameId(game.id);
      return game.copyWith(rounds: rounds);
    });

    return game;
  }

  Future<Game> deleteRound(Game game, String roundId) async {
    await _roundRepository.delete(roundId);
    final List<Round> currentRounds = game.rounds
        .where((r) => r.id != roundId)
        .toList();

    List<Player> players = [];
    final List<Round> newRounds = [];

    for (int i = 0; i < game.players.length; i++) {
      Profile profile = game.players[i].profile;
      var player = Player(
        profile: profile,
        createdAt: game.players[i].createdAt,
      );
      players.add(player);
    }

    game = game.copyWith(
      winner: null,
      isFinished: false,
      currentRound: 1,
      currentPlayerIndex: 0,
      players: players,
    );

    for (Round r in currentRounds) {
      game = _applyRound(game, r.playerScores);
      newRounds.add(r);
    }
    game = game.copyWith(rounds: newRounds);

    await _gameRepository.update(game);
    await _gameRepository.updatePlayers(game.players, game.id);
    return game;
  }

  // Game updateRound(Game game) {
  // NEXT VERSION
  //   return game;
  // }

  Future<Game> split(Game game, int bid, int bidderIndex) async {
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
    roundResultsForHistory[activePlayer.profile.id] = -bid;

    Round newRound = Round(
      roundNumber: game.rounds.length + 1,
      playerScores: roundResultsForHistory,
      specialEvents: gameEventsMap,
      gameId: game.id,
    );

    final updatedGame = game.copyWith(
      players: updatedPlayers,
      rounds: [...game.rounds, newRound],
      currentRound: game.currentRound + 1,
      currentPlayerIndex: (game.currentPlayerIndex + 1) % game.players.length,
    );

    await _gameUow.saveRoundResult(updatedGame, newRound);

    return updatedGame;
  }

  Future<Game> confirmRound({
    // NEXT VERSION: REFACTORING
    required Game game,
    required Map<String, int> points,
    required String bidderId,
    required int bid,
    required AppLocalizations l10n,
  }) async {
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
      gameId: game.id,
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
      final victoryTitle = game.getLocalizedName(l10n);
      game = game.copyWith(name: victoryTitle);
    }

    final updatedGame = await _gameUow.saveRoundResult(game, newRound);
    return updatedGame;
  }

  Future<Game> addGame(Game newGame) async {
    final game = await _gameRepository.add(newGame);
    return game;
  }

  Future<Game> addGameWithPlayers(Game newGame) async {
    final game = await _gameRepository.addFullGame(newGame);
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

  Future<Game> updateAndDeletePlayers(
    Game currentGame,
    List<Profile> newProfiles,
  ) async {
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

    await _gameRepository.syncPlayers(currentGame.id, newProfiles);

    final updatedGame = currentGame.copyWith(
      players: updatedPlayers,
      currentPlayerIndex: newIndex,
    );
    await _gameRepository.update(updatedGame);
    return updatedGame;
  }

  void addPlayer(Game currentGame, Player player) async {
    if (currentGame.players.length > maxPlayers) {
      throw Exception("Max $maxPlayers players");
    }
    final updatedGame = currentGame.copyWith(
      players: [...currentGame.players, player],
    );
    await _gameRepository.update(updatedGame);
  }

  Future<Game> startGame(List<Profile> profiles, AppLocalizations l10n) async {
    GameValidators.validatePlayerCount(profiles.length, l10n);
    List<Player> players = [];
    for (int i = 0; i < profiles.length; i++) {
      var player = Player(
        profile: profiles[i],
        createdAt: DateTime.now().add(Duration(seconds: i)),
      );
      players.add(player);
    }

    Game game = Game(players: players);
    game = await addGameWithPlayers(game);

    final persistentName = game.getLocalizedName(l10n);
    game = game.copyWith(name: persistentName);
    await _gameRepository.update(game);

    return game;
  }

  Game _applyRound(Game game, Map<String, int> points) {
    final processedPoints = Map<String, int>.from(points);

    Player? newBarrelPlayer = game.players.where((p) {
      final scoreToAdd = processedPoints[p.profile.id] ?? 0;
      final newTotal = p.totalPoints + scoreToAdd;
      return newTotal >= barrelNumber && !p.isOnBarrel;
    }).firstOrNull;

    List<Player> updatedPlayers = game.players.map((p) {
      final scoreToAdd = processedPoints[p.profile.id] ?? 0;
      final newTotal = p.totalPoints + scoreToAdd;

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
          newIsOnBarrel = false;
          newBarrelAttempts = 0;
          newTotalPoints = barrelNumber - barrelPenalty;
        } else {
          newBarrelAttempts = p.barrelAttempts + 1;
          if (newBarrelAttempts >= maxBarrelsNumber) {
            newIsOnBarrel = false;
            newBarrelAttempts = 0;
            newTotalPoints = barrelNumber - barrelPenalty;
          } else {
            newTotalPoints = barrelNumber;
          }
        }
      } else if (newTotal >= barrelNumber) {
        newIsOnBarrel = true;
        newBarrelAttempts = 0;
        newTotalPoints = barrelNumber;
      } else {
        newTotalPoints = newTotal;
      }

      final isBolt = _rulesService.isBolt(scoreToAdd, p.isOnBarrel);

      int newBoltsCount = isBolt ? p.boltsCount + 1 : p.boltsCount;
      final isMagic = _rulesService.isMagicNumber(newTotalPoints);

      final isThreeBolts = _rulesService.hasThreeBoltsFromInt(newBoltsCount);

      if (isBolt && isThreeBolts) {
        newTotalPoints -= boltPenalty;
        newBoltsCount = 0;
      }

      return p.copyWith(
        totalPoints: isMagic ? 0 : newTotalPoints,
        isOnBarrel: newIsOnBarrel,
        barrelAttempts: newBarrelAttempts,
        boltsCount: newBoltsCount,
      );
    }).toList();

    final updatedGame = game.copyWith(
      players: updatedPlayers,
      currentRound: game.currentRound + 1,
      currentPlayerIndex: (game.currentPlayerIndex + 1) % game.players.length,
    );

    return updatedGame;
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

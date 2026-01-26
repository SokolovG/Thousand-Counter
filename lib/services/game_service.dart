import '../core/constants.dart';
import '../core/logger.dart';
import '../core/utils/validators.dart';
import '../models/game.dart';
import '../models/player_game_state.dart';
import '../models/round.dart';
import 'rules_service.dart';
import 'score_service.dart';

class GameService {
  final RulesService _rulesService;
  final ScoreService _scoreService;

  GameService(this._rulesService, this._scoreService);

  void addRound(Game game, Map<String, int> points) {
    final round = Round(roundNumber: game.currentRound, playerScores: points);
    game.rounds.add(round);

    points.forEach((playerId, basePoints) {
      final player = game.playerStates.firstWhere(
        (p) => p.profile.id == playerId,
      );
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

  void addPlayer(Game game, PlayerGameState player) {
    if (game.playerStates.length >= maxPlayers) {
      throw Exception("Max $maxPlayers players");
    }
    game.playerStates.add(player);
    AppLogger.info("Player added");
  }

  Game createGame(List<PlayerGameState> players) {
    GameValidators.validatePlayerCount(players.length);
    GameValidators.validatePlayerName(
      players.map((p) => p.profile.name).toString(),
    );
    final game = Game(playerStates: players);
    AppLogger.info("Game created: $game");
    return game;
  }

  PlayerGameState? getWinner(Game game) {
    final qualifiedPlayers = game.playerStates
        .where((p) => p.totalPoints >= 1000)
        .toList();

    if (qualifiedPlayers.isEmpty) return null;

    qualifiedPlayers.sort((a, b) => b.totalPoints.compareTo(a.totalPoints));
    return qualifiedPlayers.first;
  }
}

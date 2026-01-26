import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/core/logger.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/player.dart';

class GameService {
  void addPlayer(Game game, Player player) {
    if (game.players.length >= maxPlayers) {
      throw Exception("Max $maxPlayers players");
    }
    game.players.add(player);
    AppLogger.info("Player added");
  }

  Game createGame(List<Player> players) {
    final game = Game(players: players);
    AppLogger.info("Game created: $game");
    return game;
  }

  void addRound(Game game, Map<String, int> points) {
    ///
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

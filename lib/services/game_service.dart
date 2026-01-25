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

  void createGame(List<Player> players) {
    final game = Game(players: players);
    AppLogger.info("Game created: $game");
  }

  void addRound(Game game, Map<String, int> points) {
    ///
  }

  Player getWinner(Game game) {
    // List<Player> players = game.players;
    // return players.where(Player.total_points == 10000).first;
    return game.players.first;
  }
}

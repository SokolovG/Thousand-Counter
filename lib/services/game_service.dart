import 'package:thousand_counter/constants.dart';
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
}

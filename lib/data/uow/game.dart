import 'package:thousand_counter/data/local/database.dart';
import 'package:thousand_counter/data/repositories/game.dart';
import 'package:thousand_counter/data/repositories/rounds.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/round.dart';

class GameUnitOfWork {
  final AppDatabase db;
  final GameRepository gameRepo;
  final RoundsRepository roundRepo;

  GameUnitOfWork(this.db, this.gameRepo, this.roundRepo);

  Future<Game> saveRoundResult(Game updatedGame, Round newRound) async {
    return db.transaction(() async {
      final game = await gameRepo.update(updatedGame);
      final updatedPlayers = await gameRepo.updatePlayers(
        updatedGame.players,
        updatedGame.id,
      );
      final round = await roundRepo.add(newRound);
      return game.copyWith(
        rounds: [...game.rounds, round],
        players: updatedPlayers,
      );
    });
  }
}

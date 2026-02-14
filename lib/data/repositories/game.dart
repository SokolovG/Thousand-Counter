import 'package:drift/drift.dart';
import 'package:thousand_counter/data/local/database.dart';
import 'package:thousand_counter/data/models/game.dart';
import 'package:thousand_counter/data/repositories/abstract.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/models/profile.dart';

class GameRepository implements AbstractRepository<Game> {
  final AppDatabase db;

  GameRepository(this.db) {}

  @override
  Future<Game> add(Game game) async {
    await db
        .into(db.games)
        .insert(
          GamesCompanion.insert(
            name: game.name,
            createdAt: game.createdAt,
            currentRound: game.currentRound,
            currentPlayerIndex: game.currentPlayerIndex,
            winnerPlayerId: Value(game.winner?.profile.id),
          ),
        );
    return game;
  }

  @override
  Future<void> delete(String id) async {
    await (db.delete(db.games)..where((g) => g.id.equals(id))).go();
  }

  @override
  Stream<Game?> get(String id) {
    final query = db.select(db.games)..where((g) => g.id.equals(id));
    return query.watchSingleOrNull().map((gameModel) {
      if (gameModel == null) return null;
      return Game.fromDb(gameModel);
    });
  }

  @override
  Future<List<Game>> getAll() async {
    //
  }

  @override
  Future update(Game updatedGame) async {
    final index = _games.indexWhere((game) => game.id == updatedGame.id);
    if (index != -1) {
      _games[index] = updatedGame;
    }
    return updatedGame;
  }
}

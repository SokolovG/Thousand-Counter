import 'package:drift/drift.dart';
import 'package:thousand_counter/data/local/database.dart';
import 'package:thousand_counter/data/repositories/abstract.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/models/profile.dart';

class GameRepository implements AbstractRepository<Game> {
  final AppDatabase db;

  GameRepository(this.db);

  Future<Game> addFullGame(Game game) async {
    await db.transaction(() async {
      await add(game);

      for (var player in game.players) {
        await db
            .into(db.players)
            .insert(
              PlayersCompanion.insert(
                totalPoints: Value(player.totalPoints),
                boltsCount: Value(player.boltsCount),
                barrelAttempts: Value(player.barrelAttempts),
                name: player.profile.name,
                isOnBarrel: Value(player.isOnBarrel),
                gameId: game.id,
                profileId: player.profile.id,
              ),
              mode: InsertMode.insertOrReplace,
            );
      }
    });
    return game;
  }

  @override
  Future<Game> add(Game game) async {
    // BUG: unique constraint!!!
    await db
        .into(db.games)
        .insert(
          GamesCompanion.insert(
            id: Value(game.id),
            name: game.name,
            createdAt: game.createdAt,
            currentRound: game.currentRound,
            currentPlayerIndex: game.currentPlayerIndex,
            winnerPlayerId: Value(game.winner?.profile.id),
            isFinished: Value(game.isFinished),
          ),
          mode: InsertMode.insertOrReplace,
        );
    return game;
  }

  @override
  Future<void> delete(String id) async {
    await (db.delete(db.games)..where((g) => g.id.equals(id))).go();
  }

  @override
  Stream<Game?> get(String id) {
    final query = db.select(db.games).join([
      innerJoin(db.players, db.players.gameId.equalsExp(db.games.id)),
      innerJoin(db.profiles, db.profiles.id.equalsExp(db.players.profileId)),
    ])..where(db.games.id.equals(id));
    return query.watch().map((List<TypedResult> rows) {
      if (rows.isEmpty) return null;
      final gameModel = rows.first.readTable(db.games);

      final players = rows.map((row) {
        final playerModel = row.readTable(db.players);
        final profileModel = row.readTable(db.profiles);

        return Player(
          profile: Profile(id: profileModel.id, name: profileModel.name),
          totalPoints: playerModel.totalPoints,
          boltsCount: playerModel.boltsCount,
          isOnBarrel: playerModel.isOnBarrel,
          barrelAttempts: playerModel.barrelAttempts,
        );
      }).toList();
      return Game.fromDb(gameModel).copyWith(players: players);
    });
  }

  @override
  Future<List<Game>> getAll() async {
    final query = db.select(db.games).join([
      innerJoin(db.players, db.players.gameId.equalsExp(db.games.id)),
      innerJoin(db.profiles, db.profiles.id.equalsExp(db.players.profileId)),
    ]);

    final rows = await query.get();
    final Map<String, Game> gamesMap = {};
    final Map<String, List<Player>> playersMap = {};

    for (final row in rows) {
      final gameModel = row.readTable(db.games);
      final playerModel = row.readTable(db.players);
      final profileModel = row.readTable(db.profiles);

      final player = Player(
        profile: Profile(id: profileModel.id, name: profileModel.name),
        totalPoints: playerModel.totalPoints,
        boltsCount: playerModel.boltsCount,
        isOnBarrel: playerModel.isOnBarrel,
        barrelAttempts: playerModel.barrelAttempts,
      );

      gamesMap.putIfAbsent(gameModel.id, () => Game.fromDb(gameModel));

      playersMap.putIfAbsent(gameModel.id, () => []).add(player);
    }
    return gamesMap.values.map((game) {
      return game.copyWith(players: playersMap[game.id] ?? []);
    }).toList();
  }

  @override
  Future<Game> update(Game updatedGame) async {
    await (db.update(
      db.games,
    )..where((g) => g.id.equals(updatedGame.id))).write(
      GamesCompanion(
        name: Value(updatedGame.name),
        createdAt: Value(updatedGame.createdAt),
        currentRound: Value(updatedGame.currentRound),
        currentPlayerIndex: Value(updatedGame.currentPlayerIndex),
        winnerPlayerId: Value(updatedGame.winner?.profile.id),
      ),
    );
    return updatedGame;
  }
}

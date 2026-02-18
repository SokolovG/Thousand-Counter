import 'package:drift/drift.dart';
import 'package:thousand_counter/data/local/database.dart';
import 'package:thousand_counter/data/repositories/abstract.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/models/profile.dart';

class GameRepository implements AbstractRepository<Game> {
  final AppDatabase db;

  GameRepository(this.db);

  Future<List<Player>> updatePlayers(
    List<Player> updatedPlayers,
    String gameId,
  ) async {
    for (var player in updatedPlayers) {
      await (db.update(db.players)..where(
            (p) =>
                p.gameId.equals(gameId) & p.profileId.equals(player.profile.id),
          ))
          .write(
            PlayersCompanion(
              totalPoints: Value(player.totalPoints),
              boltsCount: Value(player.boltsCount),
              barrelAttempts: Value(player.barrelAttempts),
              isOnBarrel: Value(player.isOnBarrel),
            ),
          );
    }
    return updatedPlayers;
  }

  Future<void> syncPlayers(String gameId, List<Profile> newProfiles) async {
    await db.transaction(() async {
      final currentPlayersRows = await (db.select(
        db.players,
      )..where((p) => p.gameId.equals(gameId))).get();

      final currentProfileIds = currentPlayersRows
          .map((p) => p.profileId)
          .toSet();
      final newProfileIds = newProfiles.map((p) => p.id).toSet();

      final idsToRemove = currentProfileIds.difference(newProfileIds);
      if (idsToRemove.isNotEmpty) {
        await (db.delete(db.players)..where(
              (p) => p.gameId.equals(gameId) & p.profileId.isIn(idsToRemove),
            ))
            .go();
      }

      final idsToAdd = newProfileIds.difference(currentProfileIds);
      for (var id in idsToAdd) {
        await db
            .into(db.players)
            .insert(
              PlayersCompanion.insert(
                gameId: gameId,
                profileId: id,
                totalPoints: const Value(0),
                boltsCount: const Value(0),
                barrelAttempts: const Value(0),
                isOnBarrel: const Value(false),
              ),
            );
      }
    });
  }

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
    final query =
        db.select(db.games).join([
            innerJoin(db.players, db.players.gameId.equalsExp(db.games.id)),
            innerJoin(
              db.profiles,
              db.profiles.id.equalsExp(db.players.profileId),
            ),
          ])
          ..where(db.games.id.equals(id))
          ..orderBy([OrderingTerm(expression: db.profiles.name)]);
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
      final winner = gameModel.winnerPlayerId != null
          ? players
                .where((p) => p.profile.id == gameModel.winnerPlayerId)
                .firstOrNull
          : null;

      return Game.fromDb(gameModel).copyWith(players: players, winner: winner);
    });
  }

  @override
  Future<List<Game>> getAll() async {
    final query =
        db.select(db.games).join([
          innerJoin(db.players, db.players.gameId.equalsExp(db.games.id)),
          innerJoin(
            db.profiles,
            db.profiles.id.equalsExp(db.players.profileId),
          ),
        ])..orderBy([
          OrderingTerm(expression: db.games.createdAt, mode: OrderingMode.desc),
        ]);

    final rows = await query.get();
    final Map<String, GameModel> gameModelsMap = {};
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

      gameModelsMap.putIfAbsent(gameModel.id, () => gameModel);
      playersMap.putIfAbsent(gameModel.id, () => []).add(player);
    }

    return gameModelsMap.entries.map((entry) {
      final gameModel = entry.value;
      final players = playersMap[gameModel.id] ?? [];
      final winner = gameModel.winnerPlayerId != null
          ? players
                .where((p) => p.profile.id == gameModel.winnerPlayerId)
                .firstOrNull
          : null;

      return Game.fromDb(gameModel).copyWith(players: players, winner: winner);
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
        isFinished: Value(updatedGame.isFinished),
      ),
    );
    return updatedGame;
  }
}

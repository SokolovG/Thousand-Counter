import 'package:drift/drift.dart';
import 'package:thousand_counter/data/local/database.dart';
import 'package:thousand_counter/data/repositories/abstract.dart';
import 'package:thousand_counter/models/round.dart';

class RoundsRepository implements AbstractRepository<Round> {
  final AppDatabase db;

  RoundsRepository(this.db);

  @override
  Future<Round> add(Round round) async {
    await db
        .into(db.rounds)
        .insert(
          RoundsCompanion.insert(
            roundNumber: round.roundNumber,
            playerScores: round.playerScores,
            specialEvents: round.specialEvents,
            gameId: round.gameId,
            id: Value(round.id),
          ),
        );
    return round;
  }

  @override
  Future<void> delete(String id) async {
    await (db.delete(db.rounds)..where((r) => r.id.equals(id))).go();
  }

  @override
  Stream<Round?> get(String id) {
    final query = db.select(db.rounds)..where((r) => r.id.equals(id));
    return query.watchSingleOrNull().map(
      (model) => model != null ? Round.fromDb(model) : null,
    );
  }

  Future<Round?> getByNumber(String gameId, int roundNumber) async {
    final query = db.select(db.rounds)
      ..where(
        (r) => r.gameId.equals(gameId) & r.roundNumber.equals(roundNumber),
      );

    final model = await query.getSingleOrNull();
    return model != null ? Round.fromDb(model) : null;
  }

  Future<List<Round>> getAllByGameId(String gameId) async {
    final query = db.select(db.rounds)
      ..where((r) => r.gameId.equals(gameId))
      ..orderBy([
        (r) => OrderingTerm(expression: r.roundNumber),
      ]); // Sort by round number
    final rows = await query.get();
    return rows.map((RoundModel model) {
      return Round.fromDb(model);
    }).toList();
  }

  @override
  Future<List<Round>> getAll() async {
    // For statistik

    final query = db.select(db.rounds);
    final rows = await query.get();
    return rows.map((RoundModel model) {
      return Round.fromDb(model);
    }).toList();
  }

  @override
  Future<Round> update(Round updatedRound) async {
    await (db.update(
      db.rounds,
    )..where((p) => p.id.equals(updatedRound.id))).write(
      RoundsCompanion(
        playerScores: Value(updatedRound.playerScores),
        specialEvents: Value(updatedRound.specialEvents),
      ),
    );
    return updatedRound;
  }
}

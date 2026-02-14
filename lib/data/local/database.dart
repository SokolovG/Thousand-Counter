import 'package:drift/drift.dart';
import 'package:thousand_counter/data/models/game.dart';
import 'package:thousand_counter/data/models/player.dart';
import 'package:thousand_counter/data/models/profile.dart';
import 'package:thousand_counter/data/models/round.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Profiles, Games, Players, Rounds])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'thosand_counter_database.sqlite',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  // TODO: sqlite3.wasm, drift_worker.js
}

import 'package:drift/drift.dart';
import 'package:thousand_counter/data/models/profile.dart';
import 'package:uuid/uuid.dart';

@DataClassName("GameModel")
class Games extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get currentRound => integer()();
  BoolColumn get isFinished => boolean().withDefault(const Constant(false))();
  IntColumn get currentPlayerIndex => integer()();
  TextColumn get winnerPlayerId =>
      text().references(Profiles, #id).nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

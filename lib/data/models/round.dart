import 'package:drift/drift.dart';
import 'package:thousand_counter/data/converters/map_converter.dart';
import 'package:thousand_counter/data/converters/special_events.dart';
import 'package:thousand_counter/data/models/game.dart';
import 'package:uuid/uuid.dart';

@DataClassName("RoundModel")
class Rounds extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  IntColumn get roundNumber => integer()();
  TextColumn get playerScores => text().map(MapConverter())();
  TextColumn get specialEvents => text().map(SpecialEventsConverter())();
  TextColumn get gameId => text().references(Games, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

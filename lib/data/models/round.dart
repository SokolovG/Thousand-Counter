import 'package:drift/drift.dart';
import 'package:thousand_counter/data/converters/map_converter.dart';
import 'package:thousand_counter/data/converters/special_events.dart';
import 'package:thousand_counter/data/models/game.dart';

@DataClassName("RoundModel")
class Rounds extends Table {
  IntColumn get roundNumber => integer()();
  TextColumn get playerScores => text().map(MapConverter())();
  TextColumn get specialEvents => text().map(SpecialEventsConverter())();
  IntColumn get gameId => integer().references(Games, #id)();
}

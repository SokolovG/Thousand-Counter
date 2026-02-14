import 'package:drift/drift.dart';
import 'package:thousand_counter/data/models/game.dart';
import 'package:thousand_counter/data/models/profile.dart';

class Players extends Table {
  IntColumn get totalPoints => integer().withDefault(const Constant(0))();
  IntColumn get boltsCount => integer().withDefault(const Constant(0))();
  IntColumn get barrelAttempts => integer().withDefault(const Constant(0))();
  TextColumn get name => text().withLength(min: 2, max: 20)();
  BoolColumn get isOnBarrel => boolean().withDefault(const Constant(false))();
  IntColumn get gameId => integer().references(Games, #id)();
  IntColumn get profileId => integer().references(Profiles, #id)();
}

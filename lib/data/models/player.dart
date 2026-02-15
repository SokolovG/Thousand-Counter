import 'package:drift/drift.dart';
import 'package:thousand_counter/data/models/game.dart';
import 'package:thousand_counter/data/models/profile.dart';

@DataClassName("PlayerModel")
class Players extends Table {
  IntColumn get totalPoints => integer().withDefault(const Constant(0))();
  IntColumn get boltsCount => integer().withDefault(const Constant(0))();
  IntColumn get barrelAttempts => integer().withDefault(const Constant(0))();
  BoolColumn get isOnBarrel => boolean().withDefault(const Constant(false))();
  TextColumn get gameId =>
      text().references(Games, #id, onDelete: KeyAction.cascade)();
  TextColumn get profileId => text().references(Profiles, #id)();

  @override
  Set<Column> get primaryKey => {gameId, profileId};
}

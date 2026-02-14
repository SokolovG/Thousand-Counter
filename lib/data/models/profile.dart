import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

@DataClassName("ProfileModel")
class Profiles extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text().withLength(min: 2, max: 20)();

  @override
  Set<Column> get primaryKey => {id};
}

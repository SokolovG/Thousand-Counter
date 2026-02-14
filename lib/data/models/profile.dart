import 'package:drift/drift.dart';

@DataClassName("ProfileModel")
class Profiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 2, max: 20)();

  @override
  Set<Column> get primaryKey => {id};
}

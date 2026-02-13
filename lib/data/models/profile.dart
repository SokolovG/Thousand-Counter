import 'package:drift/drift.dart';

class Profiles extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().withLength(min: 2, max: 20)();
}

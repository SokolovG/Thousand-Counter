import 'package:drift/drift.dart';

class Games extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get currentRound => integer()();
  BoolColumn get isFinished => boolean().withDefault(const Constant(false))();
  IntColumn get currentPlayerIndex => integer()();
}
//  final List<Player> players;
//   final List<Round> rounds;
//   final Player? winner;
import 'package:drift/drift.dart';
import 'package:thousand_counter/data/models/game.dart';
import 'package:thousand_counter/data/models/player.dart';
import 'package:thousand_counter/data/models/profile.dart';
import 'package:thousand_counter/data/models/round.dart';

@DriftDatabase(tables: [Profiles, Games, Players, Rounds])
class AppDatabase extends _$AppDatabase {}

class _$AppDatabase {}

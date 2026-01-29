import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/data/repositories/player.dart';
import 'package:thousand_counter/services/game.dart';
import 'package:thousand_counter/services/player.dart';
import 'package:thousand_counter/services/rules.dart';
import 'package:thousand_counter/services/score.dart';

final rulesServiceProvider = Provider((ref) => RulesService());
final scoreServiceProvider = Provider((ref) => ScoreService());
final playerRepositoryProvider = Provider((ref) => PlayerProfileRepository());
final playerServiceProvider = Provider((ref) {
  final playerRepo = ref.read(playerRepositoryProvider);
  return PlayerService(playerRepo);
});
final gameServiceProvider = Provider((ref) {
  final rulesService = ref.read(rulesServiceProvider);
  final scoreService = ref.read(scoreServiceProvider);
  return GameService(rulesService, scoreService);
});

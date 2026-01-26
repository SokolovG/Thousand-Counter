import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/services/game_service.dart';
import 'package:thousand_counter/services/rules_service.dart';
import 'package:thousand_counter/services/score_service.dart';

final rulesServiceProvider = Provider((ref) => RulesService());
final scoreServiceProvider = Provider((ref) => ScoreService());

final gameServiceProvider = Provider((ref) {
  final rulesService = ref.read(rulesServiceProvider);
  final scoreService = ref.read(scoreServiceProvider);
  return GameService(rulesService, scoreService);
});

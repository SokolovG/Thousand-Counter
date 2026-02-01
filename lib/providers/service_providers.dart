import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/data/repositories/profile.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/providers/core_providers.dart';
import 'package:thousand_counter/services/game.dart';
import 'package:thousand_counter/services/profile.dart';
import 'package:thousand_counter/services/rules.dart';
import 'package:thousand_counter/services/score.dart';
import 'package:thousand_counter/ui/screens/game_settings.dart';

final rulesServiceProvider = Provider((ref) => RulesService());
final scoreServiceProvider = Provider((ref) => ScoreService());
final profileRepositoryProvider = Provider((ref) => ProfileRepository());

final profileServiceProvider = Provider((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return ProfileService(repo);
});

final profilesListProvider = FutureProvider<List<Profile>>((ref) async {
  final playerService = ref.read(profileServiceProvider);
  return playerService.getAllProfiles();
});
final currentGameProvider = StateProvider<Game?>((ref) => null);

final gameServiceProvider = Provider((ref) {
  final talker = ref.watch(talkerProvider);
  final rulesService = ref.read(rulesServiceProvider);
  final scoreService = ref.read(scoreServiceProvider);
  return GameService(rulesService, scoreService, talker);
});

final isEditModeProvider = StateProvider.autoDispose<bool>((ref) => false);
// NOTIFIERS

final gameSetupProvider =
    StateNotifierProvider<GameSetupNotifier, GameSetupState>(
      (ref) => GameSetupNotifier(),
    );

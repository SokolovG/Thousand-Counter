import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/data/repositories/game.dart';
import 'package:thousand_counter/data/repositories/profile.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/providers/core_providers.dart';
import 'package:thousand_counter/services/game.dart';
import 'package:thousand_counter/services/profile.dart';
import 'package:thousand_counter/services/rules.dart';
import 'package:thousand_counter/services/score.dart';
import 'package:thousand_counter/ui/screens/game_settings.dart';

// REPORISTORIES PROVIDERS
final profileRepositoryProvider = Provider((ref) => ProfileRepository());
final gameRepositoryProvider = Provider((ref) => GameRepository());

// SERVICE PROVIDERS
final rulesServiceProvider = Provider((ref) => RulesService());
final scoreServiceProvider = Provider((ref) {
  final rulesService = ref.read(rulesServiceProvider);
  return ScoreService(rulesService);
});

final profileServiceProvider = Provider((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return ProfileService(repo);
});

final gameServiceProvider = Provider((ref) {
  final talker = ref.watch(talkerProvider);
  final rulesService = ref.read(rulesServiceProvider);
  final scoreService = ref.read(scoreServiceProvider);
  final gameRepo = ref.read(gameRepositoryProvider);
  return GameService(rulesService, scoreService, talker, gameRepo);
});

// DATA PROVIDERS
final currentGameProvider = StateProvider<Game?>((ref) => null);
final gameByIdProvider = FutureProvider.family<Game, String>((ref, id) async {
  final allGames = await ref.watch(gamesListProvider.future);
  return allGames.firstWhere((game) => game.id == id);
});
final isEditModeProvider = StateProvider.autoDispose<bool>((ref) => false);
final roundScoresProvider = StateProvider<Map<String, int>>((ref) => {});
final profilesListProvider = FutureProvider<List<Profile>>((ref) async {
  final profileService = ref.read(profileServiceProvider);
  return profileService.getAllProfiles();
});
final gamesListProvider = FutureProvider<List<Game>>((ref) async {
  final gameService = ref.read(gameServiceProvider);
  return gameService.getAllGames();
});
final minusPressedProvider = StateProvider<Map<String, bool>>(
  (ref) => <String, bool>{},
);
final barrelProvider = StateProvider.autoDispose<Map<String, bool>>(
  (ref) => <String, bool>{},
);

// NOTIFIERS

final gameSetupProvider =
    StateNotifierProvider.autoDispose<GameSetupNotifier, GameSetupState>(
      (ref) => GameSetupNotifier(),
    );

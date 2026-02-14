import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/data/repositories/game.dart';
import 'package:thousand_counter/data/repositories/profile.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/providers/core_providers.dart';
import 'package:thousand_counter/services/game.dart';
import 'package:thousand_counter/services/profile.dart';
import 'package:thousand_counter/services/rules.dart';
import 'package:thousand_counter/ui/screens/game_settings.dart';

// REPORISTORIES PROVIDERS
final profileRepositoryProvider = Provider((ref) {
  final db = ref.read(databaseProvider);
  ProfileRepository(db);
});
final gameRepositoryProvider = Provider((ref) {
  final db = ref.read(databaseProvider);
  GameRepository(db);
});

// SERVICE PROVIDERS
final rulesServiceProvider = Provider((ref) => RulesService());

final profileServiceProvider = Provider((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return ProfileService(repo);
});

final gameServiceProvider = Provider((ref) {
  final rulesService = ref.read(rulesServiceProvider);
  final gameRepo = ref.read(gameRepositoryProvider);
  return GameService(rulesService, gameRepo);
});

// DATA PROVIDERS
final currentGameProvider = StateProvider<Game?>((ref) => null);
final gameByIdProvider = FutureProvider.family<Game?, String>((ref, id) async {
  final gameService = ref.read(gameServiceProvider);
  return gameService.getGameById(id);
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
final activeBidderIdProvider = StateProvider<String?>((ref) => null);

final currentBidProvider = StateProvider<int>((ref) => 100);
final splitAvailableProvider = Provider<bool>((ref) {
  final roundScores = ref.watch(roundScoresProvider);
  final activeBidderId = ref.watch(activeBidderIdProvider);
  final currentGame = ref.watch(currentGameProvider);

  if (currentGame == null) return false;

  final bidderId =
      activeBidderId ??
      currentGame.players[currentGame.currentPlayerIndex].profile.id;

  final score = roundScores[bidderId] ?? 100;

  return score >= 100;
});
// NOTIFIERS

final gameSetupProvider =
    StateNotifierProvider.autoDispose<GameSetupNotifier, GameSetupState>(
      (ref) => GameSetupNotifier(),
    );

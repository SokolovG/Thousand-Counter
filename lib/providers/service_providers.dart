import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/data/repositories/game.dart';
import 'package:thousand_counter/data/repositories/profile.dart';
import 'package:thousand_counter/data/repositories/rounds.dart';
import 'package:thousand_counter/data/uow/game.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/providers/core_providers.dart';
import 'package:thousand_counter/services/game.dart';
import 'package:thousand_counter/services/profile.dart';
import 'package:thousand_counter/services/rules.dart';
import 'package:thousand_counter/ui/screens/game_settings.dart';

// REPORISTORIES PROVIDERS
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final db = ref.read(databaseProvider);
  return ProfileRepository(db);
});
final gameRepositoryProvider = Provider<GameRepository>((ref) {
  final db = ref.read(databaseProvider);
  return GameRepository(db);
});
final roundRepositoryProvider = Provider<RoundsRepository>((ref) {
  final db = ref.read(databaseProvider);
  return RoundsRepository(db);
});
final gameUnitOfWorkProvide = Provider<GameUnitOfWork>((ref) {
  final gameRepo = ref.read(gameRepositoryProvider);
  final roundRepo = ref.read(roundRepositoryProvider);
  final db = ref.read(databaseProvider);
  return GameUnitOfWork(db, gameRepo, roundRepo);
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
  final roundRepo = ref.read(roundRepositoryProvider);
  final gameUow = ref.read(gameUnitOfWorkProvide);
  return GameService(rulesService, gameRepo, roundRepo, gameUow);
});

// DATA PROVIDERS
final gameStreamProvider = StreamProvider.family<Game?, String>((ref, gameId) {
  final service = ref.watch(gameServiceProvider);
  return service.watchGame(gameId);
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
final splitAvailableProvider = Provider.family<bool, String>((ref, gameId) {
  final roundScores = ref.watch(roundScoresProvider);
  final activeBidderId = ref.watch(activeBidderIdProvider);
  final gameAsync = ref.watch(gameStreamProvider(gameId));
  final currentGame = gameAsync.value;
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

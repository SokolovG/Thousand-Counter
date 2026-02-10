import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/core/utils/validators.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/services/game.dart';
import 'package:thousand_counter/ui/theme/extension.dart';
import 'package:thousand_counter/ui/widgets/objects/profle_checkbox.dart';

class GameSettingsScreen extends ConsumerWidget {
  const GameSettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameSetupProvider);
    final notifier = ref.read(gameSetupProvider.notifier);
    final profilesAsync = ref.watch(profilesListProvider);
    final gameService = ref.read(gameServiceProvider);
    final l10n = AppLocalizations.of(context)!;
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.gameSettings),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (state.selectedIds.isNotEmpty)
            IconButton(
              onPressed: () {
                notifier.clearAll();
              },
              icon: Icon(Icons.clear_rounded),
            ),
          if (state.selectedIds.isEmpty)
            IconButton(
              onPressed: () {
                final Set<String> ids = profilesAsync.value!
                    .map((p) => p.id)
                    .toSet();

                notifier.selectAll(ids, l10n.maxPlayersError);
              },
              icon: Icon(Icons.select_all),
            ),
        ],
      ),
      body: profilesAsync.when(
        data: (profiles) {
          return Column(
            children: [
              Expanded(
                child: ProfilesCheckBoxWidget(
                  profiles: profiles,
                  selectedIds: state.selectedIds,
                  onChanged: (id) {
                    notifier.togglePlayer(id, l10n.maxPlayersError);
                  },
                ),
              ),

              if (state.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.errorMessage!,
                    style: TextStyle(
                      color: appColors.alert,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: state.isValid
                        ? () {
                            Game game = _startGame(
                              context,
                              profiles,
                              gameService,
                              state.selectedIds,
                            );
                            gameService.addGame(game);
                            ref.read(currentGameProvider.notifier).state = game;
                            context.push(
                              "/game/${game.id}?previousScreen=game_settings",
                            );
                          }
                        : null,
                    child: Text(
                      "${l10n.startGame} (${state.selectedIds.length})",
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(l10n.loadingProfiles),
              ],
            ),
          );
        },
        error: (err, trace) {
          // _talker.error("Failed to load profiles", err, trace);
          return Text(l10n.errorGeneric(err));
        },
      ),
    );
  }

  Game _startGame(
    BuildContext context,
    List<Profile> allProfiles,
    GameService gameService,
    Set<String> selectedIds,
  ) {
    final selectedProfiles = allProfiles
        .where((p) => selectedIds.contains(p.id))
        .toList();

    final dateStr = "${DateTime.now().day}.${DateTime.now().month}";
    final l10n = AppLocalizations.of(context)!;
    final name = l10n.defaultGameName(dateStr);

    final game = gameService.startGame(selectedProfiles, name: name);
    // _talker.info("Game started: $game");
    return game;
  }
}

class GameSetupState {
  final Set<String> selectedIds;
  final String? errorMessage;
  bool isValid = false;

  GameSetupState({
    required this.selectedIds,
    this.errorMessage,
    required this.isValid,
  });

  GameSetupState copyWith({
    Set<String>? selectedIds,
    String? errorMessage,
    bool? isValid,
  }) {
    return GameSetupState(
      selectedIds: selectedIds ?? this.selectedIds,
      errorMessage: errorMessage,
      isValid: isValid ?? this.isValid,
    );
  }
}

class GameSetupNotifier extends StateNotifier<GameSetupState> {
  GameSetupNotifier() : super(GameSetupState(selectedIds: {}, isValid: false));

  void selectAll(Set<String> ids, String errorText) {
    Set<String> newIds;
    String? error;
    if (GameValidators.canAddMorePlayers(ids.length)) {
      newIds = {...ids};
    } else {
      var listIds = ids.toList().take(maxPlayers);
      newIds = listIds.toSet();
    }

    state = state.copyWith(
      selectedIds: newIds,
      errorMessage: error,
      isValid: GameValidators.canStartGame(newIds.length),
    );
  }

  void togglePlayer(String id, String errorText) {
    Set<String> newIds;
    String? error;

    if (state.selectedIds.contains(id)) {
      newIds = {...state.selectedIds}..remove(id);
    } else {
      if (GameValidators.canAddMorePlayers(state.selectedIds.length)) {
        newIds = {...state.selectedIds, id};
      } else {
        newIds = state.selectedIds;
        error = errorText;
      }
    }

    state = state.copyWith(
      selectedIds: newIds,
      errorMessage: error,
      isValid: GameValidators.canStartGame(newIds.length),
    );
  }

  void clearAll() {
    state = GameSetupState(selectedIds: {}, isValid: false);
  }
}

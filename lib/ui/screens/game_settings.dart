import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/core/utils/validators.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/services/game.dart';
import 'package:thousand_counter/ui/widgets/objects/profle_checkbox.dart';

class GameSettingsScreen extends ConsumerWidget {
  const GameSettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameSetupProvider);
    final notifier = ref.read(gameSetupProvider.notifier);
    final profilesAsync = ref.watch(profilesListProvider);
    final gameService = ref.read(gameServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Game settings"),
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

                notifier.selectAll(ids);
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
                  onChanged: notifier.togglePlayer,
                ),
              ),

              if (state.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsetsGeometry.all(24),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: state.isValid
                        ? () {
                            Game game = _startGame(
                              profiles,
                              gameService,
                              state.selectedIds,
                            );
                            gameService.addGame(game);
                            ref.read(currentGameProvider.notifier).state = game;
                            context.push("/game/${game.id}");
                          }
                        : null,
                    child: Text(
                      "Start Game (${state.selectedIds.length} players)",
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
                Text("Loading profiles..."),
              ],
            ),
          );
        },
        error: (err, trace) {
          // _talker.error("Failed to load profiles", err, trace);
          return Text('Error: $err');
        },
      ),
    );
  }

  Game _startGame(
    List<Profile> allProfiles,
    GameService gameService,
    Set<String> selectedIds,
  ) {
    final selectedProfiles = allProfiles
        .where((p) => selectedIds.contains(p.id))
        .toList();
    final game = gameService.startGame(selectedProfiles);
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

  void selectAll(Set<String> ids) {
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

  void togglePlayer(String id) {
    Set<String> newIds;
    String? error;

    if (state.selectedIds.contains(id)) {
      newIds = {...state.selectedIds}..remove(id);
    } else {
      if (GameValidators.canAddMorePlayers(state.selectedIds.length)) {
        newIds = {...state.selectedIds, id};
      } else {
        newIds = state.selectedIds;
        error = "Maximum 4 players!";
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

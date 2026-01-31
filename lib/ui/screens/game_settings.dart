import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thousand_counter/core/utils/validators.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/services/game.dart';

class GameSettingsScreen extends ConsumerWidget {
  const GameSettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIds = ref.watch(gameSetupProvider);
    final notifier = ref.read(gameSetupProvider.notifier);
    final profilesAsync = ref.watch(profilesListProvider);
    final gameService = ref.read(gameServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Game settings"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: profilesAsync.when(
        data: (profiles) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: profiles.length,
                  itemBuilder: (context, index) {
                    final profile = profiles[index];
                    return CheckboxListTile(
                      title: Text(profile.name),
                      value: selectedIds.contains(profile.id),
                      onChanged: (checked) {
                        notifier.togglePlayer(profile.id);
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: GameValidators.canStartGame(selectedIds.length)
                    ? () {
                        Game game = _startGame(
                          profiles,
                          gameService,
                          selectedIds,
                        );
                        ref.read(currentGameProvider.notifier).state = game;
                        context.push("/game");
                      }
                    : null,
                child: Text("Start Game (${selectedIds.length} players)"),
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

class GameSetupNotifier extends StateNotifier<Set<String>> {
  GameSetupNotifier() : super({});

  void togglePlayer(String id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      if (GameValidators.canAddMorePlayers(state.length)) {
        state = {...state, id};
      }
    }
  }

  bool canStartGame() {
    return GameValidators.canStartGame(state.length);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/dialogs/profiles_select.dart';
import 'package:thousand_counter/ui/widgets/objects/player.dart';

class GameScreen extends ConsumerWidget {
  final String? gameId;
  const GameScreen({super.key, this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentGame = ref.watch(currentGameProvider);
    final gameService = ref.read(gameServiceProvider);

    if (currentGame == null && gameId != null) {
      final asyncGame = ref.watch(gameByIdProvider(gameId!));
      return asyncGame.when(
        data: (Game game) {
          Future.microtask(
            () => ref.read(currentGameProvider.notifier).state = game,
          );
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, st) => Scaffold(body: Center(child: Text("Error: $e"))),
      );
    }
    if (currentGame == null) {
      return const Scaffold(body: Center(child: Text("No active game")));
    }

    final players = currentGame.players;

    return Scaffold(
      appBar: AppBar(
        title: Text("Round ${currentGame.currentRound}"),
        leading: currentGame.isFinished
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  context.pop(context);
                },
              )
            : IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  context.go('/');
                },
              ),
        actions: [
          if (!currentGame.isFinished)
            IconButton(
              onPressed: () => showProfilesSelectDialog(context, ref),
              icon: const Icon(Icons.groups),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              key: ValueKey(currentGame.currentRound),
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = currentGame.players[index];
                return PlayerWidget(player: player);
              },
            ),
          ),

          if (!currentGame.isFinished)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Map<String, int> points = ref.read(roundScoresProvider);
                    ref.read(minusPressedProvider).clear();
                    Game updatedGame = gameService.confirmRound(
                      currentGame,
                      points,
                    );
                    ref.read(currentGameProvider.notifier).state = updatedGame;
                    ref.read(roundScoresProvider.notifier).state = {};
                  },
                  child: const Text("Confirm Round"),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

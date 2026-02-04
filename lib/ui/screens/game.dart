import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/dialogs/profiles_select.dart';
import 'package:thousand_counter/ui/widgets/objects/player.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(currentGameProvider);
    final gameService = ref.read(gameServiceProvider);

    if (game == null) {
      return const Scaffold(body: Center(child: Text("No active game")));
    }
    final players = game.players;

    return Scaffold(
      appBar: AppBar(
        title: Text("Round ${game.currentRound}"),
        actions: [
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
              key: ValueKey(game.currentRound),
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = game.players[index];
                return PlayerWidget(player: player);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Map<String, int> points = ref.read(roundScoresProvider);
                Game updatedGame = gameService.confirmRound(game, points);
                ref.read(currentGameProvider.notifier).state = updatedGame;
                ref.read(roundScoresProvider.notifier).state = {};
              },
              child: const Text("Confirm Round"),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/objects/player.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  void _managePlayers(BuildContext context, WidgetRef ref) {}
  void _finishRound(WidgetRef ref) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(currentGameProvider);
    if (game == null) {
      return const Scaffold(body: Center(child: Text("No game active")));
    }
    final players = game.players;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Game"),
        actions: [
          IconButton(
            onPressed: () => _managePlayers(context, ref),
            icon: const Icon(Icons.groups),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
              onPressed: () => _finishRound(ref),
              child: const Text("Confirm Round"),
            ),
          ),
        ],
      ),
    );
  }
}

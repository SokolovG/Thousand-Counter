import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/dialogs/profiles_select.dart';
import 'package:thousand_counter/ui/widgets/objects/player.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  void _finishRound(WidgetRef ref) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(currentGameProvider);

    if (game == null) {
      return const Scaffold(body: Center(child: Text("No active game")));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Game"),
        actions: [
          IconButton(
            onPressed: () => showProfilesSelectDialog(context, ref),
            icon: const Icon(Icons.groups),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: game.players.length,
                itemBuilder: (context, index) {
                  return PlayerWidget(player: game.players[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _finishRound(ref),
                  child: const Text("Confirm Round"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

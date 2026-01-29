import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thousand_counter/core/logger.dart';
import 'package:thousand_counter/providers/service_providers.dart';

class GameSettingsScreen extends ConsumerWidget {
  const GameSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(profilesListProvider);
    final gameService = ref.read(gameServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Game")),
      body: profilesAsync.when(
        data: (profiles) => Column(
          children: [
            Text("Choose players:"),

            ElevatedButton(
              onPressed: () {
                final selectedProfiles = [profiles[0], profiles[1]];
                final game = gameService.startGame(selectedProfiles);
                AppLogger.info(game);

                context.push('/game');
              },
              child: const Text("Start Game"),
            ),
          ],
        ),
        loading: () => CircularProgressIndicator(),
        error: (err, _) => Text('Error: $err'),
      ),
    );
  }
}

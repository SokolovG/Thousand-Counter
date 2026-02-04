import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/objects/game.dart';

class RecentGamesScreen extends ConsumerWidget {
  const RecentGamesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamesAsync = ref.watch(gamesListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Recent games")),
      body: gamesAsync.when(
        data: (games) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final game = games[index];
                  return GameWidget(game: game);
                },
              ),
            ),
          ],
        ),
        error: (err, stack) => Center(child: Text('Error: $err')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

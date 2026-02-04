import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/objects/game.dart';

class RecentGamesScreen extends ConsumerWidget {
  const RecentGamesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamesAsync = ref.watch(gamesListProvider);
    final isEditMode = ref.watch(isEditModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recent games"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(isEditModeProvider.notifier).update((state) => !state);
            },
            icon: Icon(isEditMode ? Icons.check : Icons.edit_outlined),
          ),
        ],
      ),
      body: gamesAsync.when(
        data: (games) => SlidableAutoCloseBehavior(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: games.length,
                  itemBuilder: (BuildContext context, int i) {
                    final game = games[i];
                    return GameWidget(game: game);
                  },
                ),
              ),
            ],
          ),
        ),

        error: (err, stack) => Center(child: Text('Error: $err')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/objects/game.dart';

class RecentGamesScreen extends ConsumerWidget {
  const RecentGamesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var gamesAsync = ref.watch(gamesListProvider);
    var isEditMode = ref.watch(isEditModeProvider);
    var l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.recentGames),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (gamesAsync.value != null && gamesAsync.value!.isNotEmpty)
            IconButton(
              onPressed: () {
                ref.read(isEditModeProvider.notifier).update((state) => !state);
              },
              icon: Icon(isEditMode ? Icons.check : Icons.edit_outlined),
            ),
        ],
      ),
      body: gamesAsync.when(
        data: (games) {
          if (games.isEmpty) {
            return Scaffold(body: Center(child: Text("Please play game!")));
          }
          return SlidableAutoCloseBehavior(
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
          );
        },

        error: (err, stack) => Center(child: Text(l10n.errorGeneric(err))),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
// TODO: если создать игру а потом удалить ПРОФИЛЬ, то в недавних играх он показывается а внутри игры нет его!
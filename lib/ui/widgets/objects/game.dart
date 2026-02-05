import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/dialogs/recent_game.dart';
import 'package:thousand_counter/ui/widgets/objects/slidable.dart';

class GameWidget extends ConsumerWidget {
  final Game game;

  const GameWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget widget = game.isFinished
        ? Icon(Icons.emoji_events, color: Colors.amber)
        : IconButton(
            onPressed: () {
              showRecentGameDialog(context, ref);
            },
            icon: Icon(Icons.play_circle_fill, color: Colors.blue),
          );

    return Slidable(
      key: ValueKey(game.id),
      groupTag: "games_list",
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              await ref.read(gameRepositoryProvider).delete(game.id);
              ref.invalidate(gamesListProvider);
            },
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: "Delete",
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SlidableObject(
            title: game.name,
            subtitle: game.players
                .map((p) => "${p.profile.name}: ${p.totalPoints}")
                .join(' • '),
            icon: widget,
            onEditCallback: (context, ref) {
              game.isFinished ? context.go("/game/${game.id}") : null;
            },
          ),
        ),
      ),
    );
  }
}

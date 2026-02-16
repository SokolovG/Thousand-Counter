import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/theme/extension.dart';
import 'package:thousand_counter/ui/widgets/objects/slidable.dart';

class GameWidget extends ConsumerWidget {
  final Game game;

  const GameWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(isEditModeProvider);
    final l10n = AppLocalizations.of(context)!;
    final appColors = Theme.of(context).extension<AppColors>()!;
    Widget icon = game.isFinished
        ? Icon(Icons.emoji_events, color: appColors.goldCrown)
        : Icon(Icons.play_circle_fill, color: appColors.iconActive);

    return Slidable(
      key: ValueKey(isEditMode),
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
            backgroundColor: appColors.iconDelete,
            icon: Icons.delete,
            label: AppLocalizations.of(context)!.delete,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: appColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: appColors.shadow,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SlidableObject(
            title: game.getLocalizedName(l10n),
            subtitle: GridView.builder(
              padding: const EdgeInsets.only(top: 8),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: 32,
              ),
              itemCount: game.players.length,
              itemBuilder: (context, index) {
                final p = game.players[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: appColors.playerHighlight.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: appColors.playerHighlight.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        game.winner == p
                            ? Icons.emoji_events
                            : Icons.person_outline,
                        size: 14,
                        color: appColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          p.profile.name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: appColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${p.totalPoints}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: appColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            icon: icon,
            onEditCallback: (context, ref) {
              context.push("/game/${game.id}?previousScreen=recent_games");
            },
          ),
        ),
      ),
    );
  }
}

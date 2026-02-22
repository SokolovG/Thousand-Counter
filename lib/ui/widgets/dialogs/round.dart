import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/core/enums.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/models/round.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/theme/extension.dart';
import 'package:thousand_counter/ui/theme/text_styles.dart';
import 'package:thousand_counter/ui/widgets/objects/event_icons.dart';

void rounDialog(
  BuildContext context,
  WidgetRef ref,
  Round round,
  List<Player> players,
  Game game,
) {
  final appColors = Theme.of(context).extension<AppColors>()!;
  final textTheme = Theme.of(context).textTheme;
  final gameService = ref.read(gameServiceProvider);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      final l10n = AppLocalizations.of(context)!;
      return SimpleDialog(
        title: Center(
          child: Text(
            l10n.roundNumber(round.roundNumber),
            style: textTheme.titleLarge,
          ),
        ),
        // actionsAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: players.map((p) {
                final score = round.playerScores[p.profile.id] ?? 0;
                final playerNotPlayed =
                    round.playerScores[p.profile.id] == null;
                final events = round.specialEvents[p.profile.id] ?? [];
                final isMagic = events.contains(SpecialGameEvent.magicNumber);
                final isFalledFromBarrel = events.contains(
                  SpecialGameEvent.barrelFall,
                );
                final isPlayerOnBarrel = events.contains(
                  SpecialGameEvent.barrel,
                );

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  leading: buildEventIcons(
                    context,
                    round.specialEvents[p.profile.id],
                  ),
                  title: Text(p.profile.name, style: textTheme.titleMedium),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!playerNotPlayed)
                        Text(
                          score > 0 ? "+$score" : "$score",
                          style: TextStyles.scoreText(
                            context,
                            color: score < 0
                                ? appColors.alert
                                : appColors.success,
                          ),
                        ),
                      if (playerNotPlayed)
                        Text(
                          l10n.playerNotPlayed,
                          style: textTheme.labelSmall?.copyWith(
                            color: appColors.warning,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (isMagic)
                        Text(
                          "→ 0",
                          style: textTheme.labelSmall?.copyWith(
                            color: appColors.warning,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (isPlayerOnBarrel && !isMagic && !isFalledFromBarrel)
                        Text(
                          "→ $barrelNumber",
                          style: textTheme.labelSmall?.copyWith(
                            color: appColors.info,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      if (isFalledFromBarrel)
                        Text(
                          "→ -$barrelPenalty",
                          style: textTheme.labelSmall?.copyWith(
                            color: appColors.alert,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Row(
            children: [
              // NEXT VERSION
              // Expanded(
              //   child: TextButton.icon(
              //     onPressed: () {},
              //     icon: Icon(Icons.edit, size: 18, color: appColors.info),
              //     label: Text(
              //       l10n.editRound,
              //       maxLines: 1,
              //       overflow: TextOverflow.ellipsis,
              //       style: textTheme.bodyMedium?.copyWith(
              //         color: appColors.info,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(width: 8),
              Expanded(
                child: TextButton.icon(
                  onPressed: () async {
                    await gameService.deleteRound(game, round.id);
                    ref.invalidate(gamesListProvider);
                    ref.invalidate(gameStreamProvider);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: appColors.alert,
                  ),
                  label: Text(
                    l10n.deleteRound,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      color: appColors.alert,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

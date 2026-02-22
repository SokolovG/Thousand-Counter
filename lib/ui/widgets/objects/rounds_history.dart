import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/core/enums.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/models/round.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/theme/extension.dart';
import 'package:thousand_counter/ui/theme/text_styles.dart';
import 'package:thousand_counter/ui/widgets/objects/event_icons.dart';

class RoundsHistoryContent extends ConsumerStatefulWidget {
  final String gameId;
  final List<Player> players;

  const RoundsHistoryContent({
    super.key,
    required this.gameId,
    required this.players,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _RoundsHistoryContentState();
  }
}

class _RoundsHistoryContentState extends ConsumerState<RoundsHistoryContent> {
  Round? selectedRound;

  @override
  Widget build(BuildContext context) {
    final game = ref.watch(gameStreamProvider(widget.gameId)).value;
    final rounds = game?.rounds ?? [];
    final roundsCount = rounds.length;
    final appColors = Theme.of(context).extension<AppColors>()!;
    final l10n = AppLocalizations.of(context)!;
    final players = widget.players;
    final textTheme = Theme.of(context).textTheme;
    final gameService = ref.read(gameServiceProvider);

    if (game == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(l10n.loadingGame),
          ],
        ),
      );
    }
    final round = selectedRound;

    return SimpleDialog(
      title: selectedRound != null
          ? Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => setState(() {
                    selectedRound = null;
                  }),
                ),
                Expanded(
                  child: Center(
                    child: Text(l10n.roundNumber(selectedRound!.roundNumber)),
                  ),
                ),
                SizedBox(width: 48),
              ],
            )
          : Center(child: Text(l10n.roundsHistory)),
      children: [
        if (roundsCount > 0)
          if (selectedRound == null)
            SizedBox(
              width: double.maxFinite,
              height: 300,
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedRound = rounds[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: (index == roundsCount - 1)
                            ? appColors.alert
                            : appColors.success,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: appColors.gridBorder,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: rounds.length,
              ),
            )
          else
            SizedBox(
              width: double.maxFinite,
              height: 232,
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: players.map((p) {
                      final score =
                          selectedRound!.playerScores[p.profile.id] ?? 0;
                      final playerNotPlayed =
                          selectedRound!.playerScores[p.profile.id] == null;
                      final events =
                          selectedRound!.specialEvents[p.profile.id] ?? [];
                      final isMagic = events.contains(
                        SpecialGameEvent.magicNumber,
                      );
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
                          selectedRound!.specialEvents[p.profile.id],
                        ),
                        title: Text(
                          p.profile.name,
                          style: textTheme.titleMedium?.copyWith(
                            color: selectedRound!.activeBidderId == p.profile.id
                                ? appColors.info
                                : null,
                          ),
                        ),
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
                            if (isPlayerOnBarrel &&
                                !isMagic &&
                                !isFalledFromBarrel)
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
              ),
            ),
        if (roundsCount <= 0)
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Center(child: Text(l10n.emptyRoundsHistory)),
          ),
        if (round != null)
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
  }
}

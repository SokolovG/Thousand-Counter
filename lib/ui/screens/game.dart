import 'dart:math' show max;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/dialogs/profiles_select.dart';
import 'package:thousand_counter/ui/widgets/dialogs/rounds_history.dart';
import 'package:thousand_counter/ui/widgets/objects/player.dart';
import 'package:thousand_counter/ui/theme/extension.dart';

class GameScreen extends ConsumerWidget {
  final String gameId;
  const GameScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameService = ref.read(gameServiceProvider);
    final queryParams = GoRouterState.of(context).uri.queryParameters;
    final previousScreen = queryParams['previousScreen'];
    final l10n = AppLocalizations.of(context)!;
    final isSplitEnabled = ref.watch(splitAvailableProvider(gameId));
    final gameAsync = ref.watch(gameStreamProvider(gameId));

    return gameAsync.when(
      data: (Game? currentGame) {
        if (currentGame == null) {
          return Scaffold(body: Center(child: Text(l10n.errorGameNotFound)));
        }
        final players = currentGame.players;
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                currentGame.isFinished
                    ? currentGame.name
                    : l10n.round(currentGame.currentRound),
              ),
            ),
            leading: previousScreen == "recent_games"
                ? IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      context.pop(context);
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {
                      context.go('/');
                    },
                  ),
            actions: [
              if (!currentGame.isFinished)
                IconButton(
                  onPressed: () =>
                      showProfilesSelectDialog(context, ref, currentGame.id),
                  icon: const Icon(Icons.groups),
                ),
              IconButton(
                onPressed: () => roundsHistoryDialog(
                  context,
                  ref,
                  currentGame.players,
                  currentGame.id,
                ),
                icon: Icon(Icons.history),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ReorderableListView.builder(
                  key: ValueKey(currentGame.currentRound),
                  buildDefaultDragHandles: false,
                  onReorder: currentGame.isFinished
                      ? (_, _) {}
                      : (oldIndex, newIndex) async {
                          if (oldIndex < newIndex) newIndex -= 1;
                          await gameService.reorderPlayers(
                            currentGame,
                            oldIndex,
                            newIndex,
                          );
                        },
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    final appColors = Theme.of(context).extension<AppColors>()!;
                    final isCurrentPlayer =
                        index == currentGame.currentPlayerIndex;
                    final color = isCurrentPlayer
                        ? appColors.playerHighlight
                        : appColors.cardBackground;

                    return Row(
                      key: ValueKey(players[index].profile.id),
                      children: [
                        if (!currentGame.isFinished)
                          ReorderableDragStartListener(
                            index: index,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: Icon(
                                Icons.drag_handle,
                                color: appColors.iconSecondary,
                              ),
                            ),
                          ),
                        Expanded(
                          child: PlayerWidget(
                            color: color,
                            isCurrentPlayer: isCurrentPlayer,
                            gameId: currentGame.id,
                            playerId: players[index].profile.id,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              if (!currentGame.isFinished)
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        Map<String, int> points = ref.read(roundScoresProvider);
                        Map<String, bool> minuses = ref.read(
                          minusPressedProvider,
                        );

                        final activeBidderId =
                            ref.read(activeBidderIdProvider) ??
                            players[currentGame.currentPlayerIndex].profile.id;

                        int bid = ref.read(currentBidProvider);

                        Map<String, int> finalPoints = {};
                        for (var player in players) {
                          String id = player.profile.id;
                          int score = points[id] ?? 0;

                          if (id == activeBidderId &&
                              score == 0 &&
                              !(minuses[id] ?? false)) {
                            score = bid;
                          }

                          bool isMinus = minuses[id] ?? false;
                          finalPoints[id] = isMinus ? -score : score;
                        }

                        await gameService.confirmRound(
                          game: currentGame,
                          points: finalPoints,
                          bidderId: activeBidderId,
                          bid: bid,
                          l10n: l10n,
                        );
                        if (!context.mounted) return;

                        ref.read(currentBidProvider.notifier).state = 100;
                        ref.read(minusPressedProvider.notifier).state = {};
                        ref.read(activeBidderIdProvider.notifier).state = null;
                        ref.read(roundScoresProvider.notifier).state = {};
                        ref.invalidate(gamesListProvider);
                      },
                      child: Text(l10n.confirmRound),
                    ),
                  ),
                ),
              if (!currentGame.isFinished)
                Padding(
                  padding: const EdgeInsets.only(
                    right: 24.0,
                    left: 24.0,
                    top: 16.0,
                    bottom: 24.0,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: isSplitEnabled
                          ? () async {
                              final scores = ref.read(roundScoresProvider);
                              final activeBidderId =
                                  ref.read(activeBidderIdProvider) ??
                                  currentGame
                                      .players[currentGame.currentPlayerIndex]
                                      .profile
                                      .id;

                              final typedBid = scores[activeBidderId] ?? 0;
                              int bid = max(
                                ref.read(currentBidProvider),
                                typedBid,
                              );

                              final bidderIndex = currentGame.players
                                  .indexWhere(
                                    (p) => p.profile.id == activeBidderId,
                                  );

                              await gameService.split(
                                currentGame,
                                bid,
                                bidderIndex,
                              );
                              ref.read(currentBidProvider.notifier).state = 100;
                              ref.read(minusPressedProvider.notifier).state =
                                  {};
                              ref.read(roundScoresProvider.notifier).state = {};
                              ref.read(activeBidderIdProvider.notifier).state =
                                  null;
                            }
                          : null,
                      child: Text(l10n.split),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      loading: () {
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
      },
      error: (err, trace) {
        return Text(l10n.errorGeneric(err));
      },
    );
  }
}

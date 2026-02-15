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

// TODO: добавление и удаление игроков не работает
// TODO: история раундов не работает
// TODO: подсчет очков не работает
// TODO: текущий игрок не работает
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
            title: Center(child: Text(l10n.round(currentGame.currentRound))),
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
                  currentGame.rounds,
                ),
                icon: Icon(Icons.history),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  key: ValueKey(currentGame.currentRound),
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    final player = currentGame.players[index];
                    final appColors = Theme.of(context).extension<AppColors>()!;
                    final isCurrentPlayer =
                        index == currentGame.currentPlayerIndex;
                    final color = isCurrentPlayer
                        ? appColors.playerHighlight
                        : appColors.cardBackground;

                    return PlayerWidget(
                      player: player,
                      color: color,
                      isCurrentPlayer: isCurrentPlayer,
                      gameId: currentGame.id,
                      playerIndex: index,
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

                        Map<String, int> finalPoints = {};
                        for (var player in players) {
                          String id = player.profile.id;
                          int score = points[id] ?? 0;

                          bool isMinus = minuses[id] ?? false;
                          finalPoints[id] = isMinus ? -score : score;
                        }

                        final activeBidderId =
                            ref.read(activeBidderIdProvider) ??
                            players[currentGame.currentPlayerIndex].profile.id;

                        int bid = points[activeBidderId] ?? 100;
                        if (bid == 0) bid = 100;

                        await gameService.confirmRound(
                          game: currentGame,
                          points: finalPoints,
                          bidderId: activeBidderId,
                          bid: bid,
                        );
                        if (!context.mounted) return;

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

                              int bid = scores[activeBidderId] ?? 100;
                              if (bid == 0) bid = 100;

                              final bidderIndex = currentGame.players
                                  .indexWhere(
                                    (p) => p.profile.id == activeBidderId,
                                  );

                              await gameService.split(
                                currentGame,
                                bid,
                                bidderIndex,
                              );
                              ref.read(activeBidderIdProvider.notifier).state =
                                  null;
                              ref.read(roundScoresProvider.notifier).state = {};
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

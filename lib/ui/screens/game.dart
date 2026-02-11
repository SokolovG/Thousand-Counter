import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/dialogs/profiles_select.dart';
import 'package:thousand_counter/ui/widgets/objects/player.dart';
import 'package:thousand_counter/ui/theme/extension.dart';

class GameScreen extends ConsumerWidget {
  final String? gameId;
  const GameScreen({super.key, this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentGame = ref.watch(currentGameProvider);
    final gameService = ref.read(gameServiceProvider);
    final queryParams = GoRouterState.of(context).uri.queryParameters;
    final previousScreen = queryParams['previousScreen'];
    final l10n = AppLocalizations.of(context)!;

    if (currentGame == null && gameId != null) {
      return ref
          .watch(gameByIdProvider(gameId!))
          .when(
            data: (Game? game) {
              Future.microtask(
                () => ref.read(currentGameProvider.notifier).state = game,
              );
              return const Center(child: CircularProgressIndicator());
            },
            loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            error: (e, st) =>
                Scaffold(body: Center(child: Text(l10n.errorGeneric(e)))),
          );
    }
    if (currentGame == null) {
      return Scaffold(body: Center(child: Text(l10n.noActiveGame)));
    }

    final players = currentGame.players;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.round(currentGame.currentRound)),
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
              onPressed: () => showProfilesSelectDialog(context, ref),
              icon: const Icon(Icons.groups),
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
                final isCurrentPlayer = index == currentGame.currentPlayerIndex;
                final color = isCurrentPlayer
                    ? Theme.of(context).colorScheme.primaryContainer
                    : appColors.cardBackground;

                return PlayerWidget(player: player, color: color);
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
                  onPressed: () {
                    Map<String, int> points = ref.read(roundScoresProvider);
                    Map<String, bool> minuses = ref.read(minusPressedProvider);

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

                    Game updatedGame = gameService.confirmRound(
                      game: currentGame,
                      points: finalPoints,
                      bidderId: activeBidderId,
                      bid: bid,
                    );

                    ref.read(minusPressedProvider.notifier).state = {};
                    ref.read(currentGameProvider.notifier).state = updatedGame;
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
                  onPressed: () {
                    final scores = ref.read(roundScoresProvider);
                    final activeBidderId =
                        ref.read(activeBidderIdProvider) ??
                        currentGame
                            .players[currentGame.currentPlayerIndex]
                            .profile
                            .id;

                    int bid = scores[activeBidderId] ?? 100;
                    if (bid == 0) bid = 100;

                    final bidderIndex = currentGame.players.indexWhere(
                      (p) => p.profile.id == activeBidderId,
                    );

                    Game updatedGame = gameService.split(
                      currentGame,
                      bid,
                      bidderIndex,
                    );
                    ref.read(currentGameProvider.notifier).state = updatedGame;
                    ref.read(activeBidderIdProvider.notifier).state = null;
                    ref.read(roundScoresProvider.notifier).state = {};
                  },
                  child: Text(l10n.split),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

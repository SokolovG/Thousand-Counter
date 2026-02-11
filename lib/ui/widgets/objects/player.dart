import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/theme/colors.dart';
import 'package:thousand_counter/ui/widgets/dialogs/player_game_history.dart';
import 'package:thousand_counter/ui/theme/extension.dart';

class PlayerWidget extends ConsumerWidget {
  final Player player;
  final Color color;

  const PlayerWidget({super.key, required this.player, required this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    final activeBidderId = ref.watch(activeBidderIdProvider);
    final currentGame = ref.watch(currentGameProvider);

    final bool isBidder = activeBidderId != null
        ? activeBidderId == player.profile.id
        : currentGame?.players[currentGame.currentPlayerIndex].profile.id ==
              player.profile.id;

    Map<String, bool> allStates = ref.watch(minusPressedProvider);
    bool isThisPlayerMinusPressed = allStates[player.profile.id] ?? false;
    bool isPlayerOnBarrel = player.isOnBarrel;
    final effectiveHintText = isBidder ? "100" : "0";
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: color,
      child: InkWell(
        onTap: () {
          playerGameHistoryDialog(context, ref);
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(player.profile.name, style: theme.textTheme.bodyLarge),
                    Text(
                      l10n.totalPoints(player.totalPoints),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (currentGame != null && !currentGame.isFinished)
                IconButton(
                  icon: Icon(
                    isBidder ? Icons.gavel : Icons.gavel_outlined,
                    color: isBidder
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outlineVariant,
                  ),
                  onPressed: () {
                    ref.read(activeBidderIdProvider.notifier).state =
                        player.profile.id;
                  },
                ),
              if (player.totalPoints >= maxPoints)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(Icons.emoji_events, color: appColors.goldCrown),
                ),

              if (isPlayerOnBarrel && player.totalPoints < maxPoints)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.oil_barrel_sharp,
                        color: player.barrelAttempts >= 2
                            ? appColors.alert
                            : appColors.barrelColor,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${player.barrelAttempts + 1}/3",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: player.barrelAttempts >= 2
                              ? appColors.alert
                              : (appColors.barrelText ??
                                    theme.colorScheme.onSurface),
                        ),
                      ),
                    ],
                  ),
                ),

              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  l10n.bolts(player.boltsCount),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              isThisPlayerMinusPressed
                  ? IconButton(
                      icon: Icon(
                        Icons.remove,
                        color: AppPalette.darkGrey,
                        size: 25.0,
                      ),
                      onPressed: () {
                        Map<String, bool> current = ref
                            .read(minusPressedProvider.notifier)
                            .state;
                        ref.read(minusPressedProvider.notifier).state = {
                          ...current,
                          player.profile.id: false,
                        };
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.remove, color: AppPalette.lightGrey),
                      onPressed: () {
                        Map<String, bool> current = ref
                            .read(minusPressedProvider.notifier)
                            .state;
                        ref.read(minusPressedProvider.notifier).state = {
                          ...current,
                          player.profile.id: true,
                        };
                      },
                    ),
              SizedBox(
                width: 60,
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}$')),
                  ],
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    ref.read(roundScoresProvider.notifier).state = {
                      ...ref.read(roundScoresProvider),
                      player.profile.id: int.tryParse(value) ?? 0,
                    };
                  },
                  decoration: InputDecoration(hintText: effectiveHintText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

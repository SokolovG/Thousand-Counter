import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/dialogs/player_game_history.dart';

class PlayerWidget extends ConsumerWidget {
  final Player player;
  final Color color;

  const PlayerWidget({super.key, required this.player, required this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    Map<String, bool> allStates = ref.watch(minusPressedProvider);
    bool isThisPlayerMinusPressed = allStates[player.profile.id] ?? false;
    bool isPlayerOnBarrel = player.isOnBarrel;

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
                    Text(
                      player.profile.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: theme.textTheme.bodyLarge?.fontSize,
                      ),
                    ),
                    Text(
                      "Total: ${player.totalPoints}",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: theme.textTheme.bodyMedium?.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
              if (player.totalPoints >= maxPoints)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(Icons.emoji_events, color: Colors.amber),
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
                            ? Colors.red
                            : Colors.orange,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${player.barrelAttempts + 1}/3",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: player.barrelAttempts >= 2
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  "B: ${player.boltsCount}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              isThisPlayerMinusPressed
                  ? IconButton(
                      icon: Icon(Icons.remove, color: Colors.black, size: 25.0),
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
                      icon: Icon(Icons.remove, color: Colors.grey),
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
                  decoration: InputDecoration(hintText: "0"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

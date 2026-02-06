import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/providers/service_providers.dart';

class PlayerWidget extends ConsumerWidget {
  final Player player;

  const PlayerWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    // final gameService = ref.read(gameServiceProvider);
    Map<String, bool> allStates = ref.watch(minusPressedProvider);
    bool isThisPlayerMinusPressed = allStates[player.profile.id] ?? false;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+$')),
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
    );
  }
}

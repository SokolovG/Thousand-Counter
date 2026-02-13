import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/core/enums.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/round.dart';
import 'package:thousand_counter/ui/widgets/objects/event_icons.dart';

void roundialog(
  BuildContext context,
  WidgetRef ref,
  Round round,
  Game currentGame,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final l10n = AppLocalizations.of(context)!;
      return AlertDialog(
        title: Center(child: Text(l10n.roundNumber(round.roundNumber))),
        actionsAlignment: MainAxisAlignment.center,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: currentGame.players.map((p) {
            final score = round.playerScores[p.profile.id] ?? 0;
            final events = round.specialEvents[p.profile.id] ?? [];
            final isMagic = events.contains(SpecialGameEvent.magicNumber);
            final isFalledFromBarrel = events.contains(
              SpecialGameEvent.barrelFall,
            );
            final isPlayerOnBarrel = events.contains(SpecialGameEvent.barrel);

            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: buildEventIcons(round.specialEvents[p.profile.id]),
              title: Text(p.profile.name),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    score > 0 ? "+$score" : "$score",
                    style: TextStyle(
                      color: score < 0 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isMagic)
                    Text(
                      "→ 0",
                      style: TextStyle(color: Colors.orange, fontSize: 12),
                    ),
                  if (isPlayerOnBarrel && !isMagic && !isFalledFromBarrel)
                    Text(
                      "→ $barrelNumber",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (isFalledFromBarrel)
                    Text(
                      "→ -$barrelPenalty",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                ],
              ),
            );
          }).toList(),
        ),
        actions: [
          Row(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, size: 18, color: Colors.blue),
                label: Text(
                  l10n.editRound,
                  style: const TextStyle(color: Colors.blue),
                ),
              ),

              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: Colors.red,
                ),
                label: Text(
                  l10n.deleteRound,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

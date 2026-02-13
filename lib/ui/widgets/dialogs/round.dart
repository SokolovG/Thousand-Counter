import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        title: Center(child: Text(l10n.roundNumber(currentGame.currentRound))),
        actionsAlignment: MainAxisAlignment.center,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: currentGame.players.map((p) {
            final score = round.playerScores[p.profile.id] ?? 0;
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: buildEventIcons(round.specialEvents[p.profile.id]),
              title: Text(p.profile.name),
              trailing: Text(
                score > 0 ? "+$score" : "$score",
                style: TextStyle(
                  color: score > 0
                      ? Colors.green
                      : (score < 0 ? Colors.red : Colors.grey),
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
        actions: [
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
            icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
            label: Text(
              l10n.deleteRound,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

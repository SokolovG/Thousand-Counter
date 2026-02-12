import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/round.dart';

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
      return SimpleDialog(
        title: Center(child: Text(l10n.roundDetails)),
        children: currentGame.players.map((p) {
          final score = round.playerScores[p.profile.id] ?? 0;
          return ListTile(
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
      );
    },
  );
}

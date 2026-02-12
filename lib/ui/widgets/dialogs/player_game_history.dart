import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/models/round.dart';
import 'package:thousand_counter/providers/service_providers.dart';

void playerGameHistoryDialog(
  BuildContext context,
  WidgetRef ref,
  Player player,
) async {
  final currentGame = ref.read(currentGameProvider);

  if (currentGame == null) return;
  final List<Round> rounds = currentGame.rounds;
  String scoreInRound = rounds
      .map((round) => round.playerScores[player.profile.id])
      .toString();
  String roundNumber = rounds.map((round) => round.roundNumber).toString();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(currentGame.name),
      content: Text("N$roundNumber - $scoreInRound"),
    ),
  );
}

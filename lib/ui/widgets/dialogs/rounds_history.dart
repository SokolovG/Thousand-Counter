import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/ui/widgets/objects/rounds_history.dart';

void roundsHistoryDialog(
  BuildContext context,
  WidgetRef ref,
  List<Player> players,
  String gameId,
) {
  showDialog(
    context: context,
    builder: (context) =>
        RoundsHistoryContent(gameId: gameId, players: players),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/providers/service_providers.dart';

void playerGameHistoryDialog(
  BuildContext context,
  WidgetRef ref,
  String? gameId,
) {
  final Game? currentGame = ref.read(currentGameProvider);
  if (currentGame == null && gameId != null) {
    final Game = ref.watch(gameByIdProvider(gameId));
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(AppLocalizations.of(context)!.playerGameHistory),
        ),
        content: SizedBox(child: Text("")),
      );
    },
  );
}

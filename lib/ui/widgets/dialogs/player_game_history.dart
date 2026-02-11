import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/providers/service_providers.dart';

void playerGameHistoryDialog(BuildContext context, WidgetRef ref) async {
  final currentGame = ref.read(currentGameProvider);

  if (currentGame == null) return;

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(currentGame.name),
      content: Text("Тут будет история - ${currentGame.name}"),
    ),
  );
}

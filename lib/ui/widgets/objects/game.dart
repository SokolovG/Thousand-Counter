import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/models/game.dart';

class GameWidget extends ConsumerWidget {
  final Game game;

  const GameWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(child: Text(game.players.toString()));
  }
}

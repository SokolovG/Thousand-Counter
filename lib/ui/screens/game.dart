import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/providers/service_providers.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(currentGameProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Game")),
      body: Column(
        children: [
          Text("Game with ${game?.players.map((p) => p.profile.name)}"),
        ],
      ),
    );
  }
}

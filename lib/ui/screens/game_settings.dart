import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/core/logger.dart';
import 'package:thousand_counter/providers/service_providers.dart';

class GameSettingsScreen extends ConsumerWidget {
  const GameSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameService = ref.read(gameServiceProvider);
    AppLogger.info(gameService);

    return Scaffold(
      appBar: AppBar(title: const Text("Game")),
      body: Column(
        children: [
          Text("Please choose players: "),
          ElevatedButton(
            onPressed: () {
              // List<PlayerProfile> players = playerService.getAllProfiles()
              // List<PlayerProfile> playersProfiles = [];
              // Player sonya = Player(profile: sonyaProfile);
              // Player grisha = Player(profile: grishaProfile);
              // gameService.startGame([sonya, grisha]);
            },
            child: const Text("Start Game"),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/core/logger.dart';
import 'package:thousand_counter/models/player_game_state.dart';
import 'package:thousand_counter/models/player_profile.dart';
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
              PlayerProfile sonyaProfile = PlayerProfile(name: "Sonya");
              PlayerProfile grishaProfile = PlayerProfile(name: "Grischa");
              PlayerGameState sonya = PlayerGameState(profile: sonyaProfile);
              PlayerGameState grisha = PlayerGameState(profile: grishaProfile);
              gameService.startGame([sonya, grisha]);
            },
            child: const Text("Start Game"),
          ),
        ],
      ),
    );
  }
}

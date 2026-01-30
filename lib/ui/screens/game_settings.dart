import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
import 'package:thousand_counter/core/logger.dart';
import 'package:thousand_counter/providers/service_providers.dart';

class GameSettingsScreen extends ConsumerStatefulWidget {
  const GameSettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _GameSettingsScreenState();
  }
}

class _GameSettingsScreenState extends ConsumerState<GameSettingsScreen> {
  final Set<String> _selectedProfileIds = {};

  @override
  Widget build(BuildContext context) {
    final profilesAsync = ref.watch(profilesListProvider);
    final gameService = ref.read(gameServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Game settings"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: profilesAsync.when(
        data: (profiles) {
          return Column(
            children: [
              Expanded(child: ListView()),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Start Game (${_selectedProfileIds.length} players)",
                ),
              ),
            ],
          );
        },
        loading: () {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("Loading profiles..."),
              ],
            ),
          );
        },
        error: (err, trace) {
          AppLogger.error("Failed to load profiles", err, trace);
          return Text('Error: $err');
        },
      ),
    );
  }
}

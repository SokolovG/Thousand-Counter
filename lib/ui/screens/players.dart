import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/models/player_profile.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/objects/player.dart';

class PlayersScreen extends ConsumerWidget {
  const PlayersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsync = ref.watch(playersListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Players"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_circle_outline_sharp),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined)),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: playersAsync.when(
        data: (players) => ListView.builder(
          itemCount: players.length,
          itemBuilder: (context, i) => PlayerWidget(name: players[i].name),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

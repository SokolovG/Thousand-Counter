import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/models/player_profile.dart';
import 'package:thousand_counter/ui/widgets/objects/player.dart';

class PlayersScreen extends ConsumerWidget {
  const PlayersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PlayerProfile sonyaProfile = PlayerProfile(name: "Sonya");
    PlayerProfile grishaProfile = PlayerProfile(name: "Grischa");
    final List<PlayerProfile> players = [sonyaProfile, grishaProfile];
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
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, i) =>
            PlayerWidget(name: players.elementAt(i).name),
      ),
    );
  }
}

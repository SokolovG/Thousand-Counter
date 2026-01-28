import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/models/player_profile.dart';

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, i) =>
            ListTile(title: Text(players.elementAt(i).name)),
      ),
    );
  }
}

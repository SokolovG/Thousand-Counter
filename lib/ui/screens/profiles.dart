import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/objects/player.dart';
import 'package:thousand_counter/ui/widgets/objects/player_dialogs.dart';

class ProfilesScreen extends ConsumerWidget {
  const ProfilesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(profilesListProvider);
    final profileService = ref.read(profileServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Players profiles"),
        actions: [
          IconButton(
            onPressed: () async {
              final name = await showPlayerEditDialog(context);
              if (name != null && name.isNotEmpty) {
                await profileService.addProfile(name);
                ref.invalidate(profilesListProvider);
              }
            },
            icon: Icon(Icons.add_circle_outline_sharp),
          ),

          IconButton(onPressed: () async {}, icon: Icon(Icons.edit_outlined)),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: profilesAsync.when(
        data: (profiles) => ListView.builder(
          itemCount: profiles.length,
          itemBuilder: (context, i) {
            final profile = profiles[i];
            return PlayerWidget(profile: profile);
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

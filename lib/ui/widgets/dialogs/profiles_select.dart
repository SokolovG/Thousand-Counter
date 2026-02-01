import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/objects/profle_checkbox.dart';

void showProfilesSelectDialog(BuildContext context, WidgetRef ref) {
  final allProfilesAsync = ref.read(profilesListProvider);
  final game = ref.read(currentGameProvider);
  final gameService = ref.read(gameServiceProvider);

  if (game == null) return;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Who is playing?"),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: Consumer(
            builder: (context, ref, child) {
              final activeGame = ref.watch(currentGameProvider);
              if (activeGame == null) return const SizedBox();

              return allProfilesAsync.when(
                data: (profiles) => ProfilesCheckBoxWidget(
                  profiles: profiles,
                  selectedIds: activeGame.players
                      .map((p) => p.profile.id)
                      .toSet(),
                  onChanged: (id) {
                    final currentProfiles = game.players
                        .map((p) => p.profile)
                        .toList();
                    List<Profile> updatedProfiles;
                    if (currentProfiles.any((p) => p.id == id)) {
                      updatedProfiles = currentProfiles
                          .where((p) => p.id != id)
                          .toList();
                    } else {
                      final newProfile = profiles.firstWhere((p) => p.id == id);
                      updatedProfiles = [...currentProfiles, newProfile];
                    }
                    final updatedGame = gameService.updatePlayers(
                      game,
                      updatedProfiles,
                    );
                    ref.read(currentGameProvider.notifier).state = updatedGame;
                  },
                ),
                error: (err, stack) => Text("Error: $err"),
                loading: () => const CircularProgressIndicator(),
              );
            },
          ),
        ),
      );
    },
  );
}

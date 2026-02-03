import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/widgets/objects/profle_checkbox.dart';

void showProfilesSelectDialog(BuildContext context, WidgetRef ref) {
  final allProfilesAsync = ref.read(profilesListProvider);
  final gameService = ref.read(gameServiceProvider);

  showDialog(
    context: context,
    builder: (context) {
      String errorText = "";
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Who is playing?"),
            content: SizedBox(
              width: double.maxFinite,
              height: 350,
              child: Column(
                children: [
                  Expanded(
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
                              final currentProfiles = activeGame.players
                                  .map((p) => p.profile)
                                  .toList();

                              List<Profile> updatedProfiles;
                              if (currentProfiles.any((p) => p.id == id)) {
                                if (currentProfiles.length <= 2) {
                                  setState(() {
                                    errorText = "Minimum 2 players!";
                                  });
                                  return;
                                }
                                updatedProfiles = currentProfiles
                                    .where((p) => p.id != id)
                                    .toList();
                              } else {
                                if (currentProfiles.length >= 4) {
                                  setState(() {
                                    errorText = "Maximum 4 players!";
                                  });
                                  return;
                                }

                                final newProfile = profiles.firstWhere(
                                  (p) => p.id == id,
                                );
                                updatedProfiles = [
                                  ...currentProfiles,
                                  newProfile,
                                ];
                              }
                              final updatedGame = gameService.updatePlayers(
                                activeGame,
                                updatedProfiles,
                              );
                              ref.read(currentGameProvider.notifier).state =
                                  updatedGame;
                            },
                          ),
                          error: (err, stack) => Text("Error: $err"),
                          loading: () => const CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                  if (errorText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        errorText,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

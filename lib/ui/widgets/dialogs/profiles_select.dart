import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/theme/extension.dart';
import 'package:thousand_counter/ui/widgets/objects/profle_checkbox.dart';

void showProfilesSelectDialog(BuildContext context, WidgetRef ref) {
  final allProfilesAsync = ref.read(profilesListProvider);
  final gameService = ref.read(gameServiceProvider);
  final theme = Theme.of(context);
  final appColors = theme.extension<AppColors>()!;

  showDialog(
    context: context,
    builder: (context) {
      final l10n = AppLocalizations.of(context)!;
      String errorText = "";
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Center(child: Text(l10n.whoIsPlaying)),
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
                                    errorText = l10n.minPlayersError;
                                  });
                                  return;
                                }
                                updatedProfiles = currentProfiles
                                    .where((p) => p.id != id)
                                    .toList();
                              } else {
                                if (currentProfiles.length >= 4) {
                                  setState(() {
                                    errorText = l10n.maxPlayersError;
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
                          error: (err, stack) => Text(l10n.errorGeneric(err)),
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
                        style: TextStyle(color: appColors.alert),
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

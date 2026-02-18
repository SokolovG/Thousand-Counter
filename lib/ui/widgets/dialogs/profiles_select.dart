import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/theme/text_styles.dart';
import 'package:thousand_counter/ui/widgets/objects/profle_checkbox.dart';

void showProfilesSelectDialog(
  BuildContext context,
  WidgetRef ref,
  String gameId,
) {
  final l10n = AppLocalizations.of(context)!;

  showDialog(
    context: context,
    builder: (context) {
      String errorText = "";
      return Consumer(
        builder: (context, ref, child) {
          final gameAsync = ref.watch(gameStreamProvider(gameId));
          final allProfilesAsync = ref.watch(profilesListProvider);
          final gameService = ref.read(gameServiceProvider);

          return gameAsync.when(
            data: (Game? currentGame) {
              if (currentGame == null) return const SizedBox();

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
                            child: allProfilesAsync.when(
                              data: (profiles) {
                                final inGame = currentGame.players
                                    .map((p) => p.profile)
                                    .toList();
                                final inGameIds = inGame
                                    .map((p) => p.id)
                                    .toSet();

                                final notInGame = profiles
                                    .where((p) => !inGameIds.contains(p.id))
                                    .toList();

                                final sortedProfiles = [
                                  ...inGame,
                                  ...notInGame,
                                ];

                                return ProfilesCheckBoxWidget(
                                  profiles: sortedProfiles,
                                  selectedIds: currentGame.players
                                      .map((p) => p.profile.id)
                                      .toSet(),
                                  onChanged: (id) async {
                                    final currentSelectedIds = currentGame
                                        .players
                                        .map((p) => p.profile.id)
                                        .toSet();

                                    if (currentSelectedIds.contains(id)) {
                                      if (currentSelectedIds.length <=
                                          minPlayers) {
                                        setState(
                                          () =>
                                              errorText = l10n.minPlayersError,
                                        );
                                        return;
                                      }
                                      currentSelectedIds.remove(id);
                                    } else {
                                      if (currentSelectedIds.length >=
                                          maxPlayers) {
                                        setState(
                                          () =>
                                              errorText = l10n.maxPlayersError,
                                        );
                                        return;
                                      }
                                      currentSelectedIds.add(id);
                                    }

                                    final existing = currentGame.players
                                        .map((p) => p.profile)
                                        .where(
                                          (p) =>
                                              currentSelectedIds.contains(p.id),
                                        )
                                        .toList();

                                    final newcomers = profiles
                                        .where(
                                          (p) =>
                                              currentSelectedIds.contains(
                                                p.id,
                                              ) &&
                                              !currentGame.players.any(
                                                (cp) => cp.profile.id == p.id,
                                              ),
                                        )
                                        .toList();

                                    final sortedProfiles = [
                                      ...existing,
                                      ...newcomers,
                                    ];

                                    await gameService.updateAndDeletePlayers(
                                      currentGame,
                                      sortedProfiles,
                                    );

                                    ref
                                            .read(
                                              activeBidderIdProvider.notifier,
                                            )
                                            .state =
                                        null;

                                    setState(() => errorText = "");
                                  },
                                );
                              },
                              error: (err, stack) =>
                                  Text(l10n.errorGeneric(err)),
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          if (errorText.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                errorText,
                                style: TextStyles.errorSmall(context),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            error: (err, stack) =>
                AlertDialog(content: Text(l10n.errorGeneric(err.toString()))),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
      );
    },
  );
}

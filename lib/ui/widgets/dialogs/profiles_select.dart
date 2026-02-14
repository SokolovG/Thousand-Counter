import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/profile.dart';
import 'package:thousand_counter/providers/service_providers.dart';
import 'package:thousand_counter/ui/theme/text_styles.dart';
import 'package:thousand_counter/ui/widgets/objects/profle_checkbox.dart';

void showProfilesSelectDialog(
  BuildContext context,
  WidgetRef ref,
  String gameId,
) {
  final allProfilesAsync = ref.read(profilesListProvider);
  final gameService = ref.read(gameServiceProvider);
  final gameAsync = ref.read(gameStreamProvider(gameId));

  gameAsync.when(
    data: (Game? currentGame) {
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
                            if (currentGame == null) return const SizedBox();

                            return allProfilesAsync.when(
                              data: (profiles) => ProfilesCheckBoxWidget(
                                profiles: profiles,
                                selectedIds: currentGame.players
                                    .map((p) => p.profile.id)
                                    .toSet(),
                                onChanged: (id) async {
                                  final currentSelectedIds = currentGame.players
                                      .map((p) => p.profile.id)
                                      .toSet();

                                  if (currentSelectedIds.contains(id)) {
                                    if (currentSelectedIds.length <=
                                        minPlayers) {
                                      setState(
                                        () => errorText = l10n.minPlayersError,
                                      );
                                      return;
                                    }
                                    currentSelectedIds.remove(id);
                                  } else {
                                    if (currentSelectedIds.length >=
                                        maxPlayers) {
                                      setState(
                                        () => errorText = l10n.maxPlayersError,
                                      );
                                      return;
                                    }
                                    currentSelectedIds.add(id);
                                  }

                                  final List<Profile> sortedProfiles = profiles
                                      .where(
                                        (p) =>
                                            currentSelectedIds.contains(p.id),
                                      )
                                      .toList();

                                  await gameService.updatePlayers(
                                    currentGame,
                                    sortedProfiles,
                                  );

                                  setState(() => errorText = "");
                                },
                              ),
                              error: (err, stack) =>
                                  Text(l10n.errorGeneric(err)),
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
      );
    },
    error: (Object error, StackTrace stackTrace) {},
    loading: () {},
  );
}

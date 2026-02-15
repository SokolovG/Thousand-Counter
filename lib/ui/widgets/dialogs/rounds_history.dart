import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/models/round.dart';
import 'package:thousand_counter/ui/theme/extension.dart';
import 'package:thousand_counter/ui/widgets/dialogs/round.dart';

void roundsHistoryDialog(
  BuildContext context,
  WidgetRef ref,
  List<Player> players,
  List<Round> rounds,
) {
  final appColors = Theme.of(context).extension<AppColors>()!;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final l10n = AppLocalizations.of(context)!;
      int roundsCount = rounds.length;
      return SimpleDialog(
        title: Center(child: Text(l10n.roundsHistory)),
        children: [
          roundsCount > 0
              ? SizedBox(
                  width: double.maxFinite,
                  height: 300,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          roundialog(context, ref, rounds[index], players);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: (index == roundsCount - 1)
                                ? appColors.alert
                                : appColors.success,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: appColors.gridBorder,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: rounds.length,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(child: Text(l10n.emptyRoundsHistory)),
                ),
        ],
      );
    },
  );
}

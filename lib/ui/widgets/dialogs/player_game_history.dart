import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/models/player_stats.dart';
import 'package:thousand_counter/providers/service_providers.dart';

void playerGameHistoryDialog(
  BuildContext context,
  WidgetRef ref,
  Player player,
  PlayerStats playerStats,
) async {
  final currentGame = ref.read(currentGameProvider);
  final l10n = AppLocalizations.of(context)!;

  if (currentGame == null) return;

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(child: Text(player.profile.name)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Center(child: Text(l10n.liveStatus)),
              Card(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.flash_on),
                        Text(": ${playerStats.currentBolts}"),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.oil_barrel),
                        Text(": ${playerStats.currentBarrels}"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Center(child: Text(l10n.generalStatistics)),
              Card(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Icon(Icons.flash_on),
                        Text(": ${playerStats.totalBolts}"),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(Icons.oil_barrel),
                        Text(": ${playerStats.totalBarrels}"),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(Icons.auto_fix_high),
                        Text(": ${playerStats.totalMagicNumbers}"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

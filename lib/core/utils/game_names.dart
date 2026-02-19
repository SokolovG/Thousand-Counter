import 'dart:math';

import 'package:thousand_counter/l10n/app_localizations.dart';

String generateGameName(AppLocalizations l10n) {
  final random = Random();
  final variants = [
    l10n.funnyTitle_0,
    l10n.funnyTitle_1,
    l10n.funnyTitle_2,
    l10n.funnyTitle_3,
    l10n.funnyTitle_4,
    l10n.funnyTitle_5,
  ];
  String name = variants[random.nextInt(variants.length)];
  return name;
}

String generateVictoryGameName(String winnerName, AppLocalizations l10n) {
  final random = Random();
  final variants = [
    l10n.gameTitleVictory_0(winnerName),
    l10n.gameTitleVictory_1(winnerName),
    l10n.gameTitleVictory_2(winnerName),
  ];
  String name = variants[random.nextInt(variants.length)];
  return name;
}

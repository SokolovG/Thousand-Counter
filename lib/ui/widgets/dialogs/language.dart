import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';

void languageDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text(AppLocalizations.of(context)!.language)),
        content:
            SizedBox(child: Text(AppLocalizations.of(context)!.chooseLanguage)),
      );
    },
  );
}

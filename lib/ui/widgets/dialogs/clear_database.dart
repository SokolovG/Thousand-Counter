import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/providers/core_providers.dart';
// import 'package:thousand_counter/l10n/app_localizations.dart';

void clearDatabaseDialog(BuildContext context, WidgetRef ref) {
  final l10n = AppLocalizations.of(context)!;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text(l10n.databaseDelete)),
        content: ElevatedButton(
          onPressed: () async {
            final db = ref.read(databaseProvider);
            await db.clearDatabase();
          },
          child: Text(l10n.confirm),
        ),
      );
    },
  );
}

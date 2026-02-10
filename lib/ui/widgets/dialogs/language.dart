import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/providers/service_providers.dart';

void languageDialog(BuildContext context, WidgetRef ref) {
  final currentLocale = ref.watch(localeProvider);
  // TODO: handle languages properly in the app
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text(AppLocalizations.of(context)!.language)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("English"),
              trailing: currentLocale.languageCode == 'en'
                  ? Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                ref.read(localeProvider.notifier).state = Locale('en');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Русский"),
              trailing: currentLocale.languageCode == 'ru'
                  ? Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                ref.read(localeProvider.notifier).state = Locale('ru');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}

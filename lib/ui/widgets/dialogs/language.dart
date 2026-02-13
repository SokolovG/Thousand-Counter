import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/providers/core_providers.dart';
import 'package:thousand_counter/providers/settings_providers.dart';
import 'package:thousand_counter/ui/utils.dart';

void languageDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final currentLocale = ref.watch(localeProvider);
          final availableLocales = AppLocalizations.supportedLocales;

          return AlertDialog(
            title: Center(child: Text(AppLocalizations.of(context)!.language)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: availableLocales.map((locale) {
                final label = getLocaleLabel(locale);
                return RadioGroup<Locale>(
                  groupValue: currentLocale,
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(localeProvider.notifier).state = value;
                      ref
                          .read(prefsManagerProvider)
                          .setString("language_code", value.languageCode);
                    }
                  },
                  child: RadioListTile(value: locale, title: Text(label)),
                );
              }).toList(),
            ),
          );
        },
      );
    },
  );
}

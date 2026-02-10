import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/providers/settings_providers.dart';

void themaDialog(BuildContext context, WidgetRef ref) {
  final currentTheme = ref.watch(themeModeProvider);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      final l10n = AppLocalizations.of(context)!;
      final themeOptions = [
        (ThemeMode.system, l10n.themeSystem),
        (ThemeMode.light, l10n.themeLight),
        (ThemeMode.dark, l10n.themeDark),
      ];

      return AlertDialog(
        title: Center(child: Text(l10n.theme)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: themeOptions.map((option) {
            final (mode, label) = option;
            return RadioGroup<ThemeMode>(
              groupValue: currentTheme,
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeModeProvider.notifier).state = value;
                  Navigator.of(context).pop();
                }
              },
              child: RadioListTile(value: mode, title: Text(label)),
            );
          }).toList(),
        ),
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/providers/settings_providers.dart';
import 'package:thousand_counter/ui/utils.dart';

void themaDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final currentTheme = ref.watch(themeModeProvider);
          final availableThemes = ref.watch(availableThemesProvider);
          final l10n = AppLocalizations.of(context)!;

          return AlertDialog(
            title: Center(child: Text(l10n.theme)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: availableThemes.map((mode) {
                final label = getThemeLabel(mode, l10n);
                return RadioGroup<ThemeMode>(
                  groupValue: currentTheme,
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(themeModeProvider.notifier).state = value;
                    }
                  },
                  child: RadioListTile(value: mode, title: Text(label)),
                );
              }).toList(),
            ),
          );
        },
      );
    },
  );
}

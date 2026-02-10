import 'package:flutter/material.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';

String getThemeLabel(ThemeMode mode, AppLocalizations l10n) {
  switch (mode) {
    case ThemeMode.system:
      return l10n.themeSystem;
    case ThemeMode.light:
      return l10n.themeLight;
    case ThemeMode.dark:
      return l10n.themeDark;
  }
}

String getLocaleLabel(Locale locale) {
  switch (locale.languageCode) {
    case "en":
      return "English";
    case "ru":
      return "Русский";
    default:
      return locale.languageCode.toUpperCase();
  }
}

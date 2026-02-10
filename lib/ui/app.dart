import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/ui/theme/theme.dart';
import 'package:thousand_counter/router/app_router.dart';
import 'package:thousand_counter/providers/settings_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThousandCounterApp extends ConsumerWidget {
  const ThousandCounterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: supportedLocales,
      routerConfig: appRouter,
      onGenerateTitle: (BuildContext context) {
        return AppLocalizations.of(context)!.appTitle;
      },
      locale: locale,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
    );
  }
}

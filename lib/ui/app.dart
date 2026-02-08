import 'package:flutter/material.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/ui/theme/default.dart';
import 'package:thousand_counter/router/app_router.dart';

class ThousandCounterApp extends StatelessWidget {
  const ThousandCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter,
      onGenerateTitle: (BuildContext context) {
        return AppLocalizations.of(context)!.appTitle;
      },
      theme: defaultTheme,
    );
  }
}

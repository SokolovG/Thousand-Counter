import 'package:flutter/material.dart';
import 'package:thousand_counter/ui/theme/default.dart';
import 'package:thousand_counter/router/app_router.dart';

class ThousandCounterApp extends StatelessWidget {
  const ThousandCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Thousand Counter',
      theme: defaultTheme,
    );
  }
}

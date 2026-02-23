import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thousand_counter/providers/core_providers.dart';
import 'package:thousand_counter/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = !(prefs.getBool('onboarding_shown') ?? false);
  if (isFirstLaunch) {
    prefs.setBool('onboarding_shown', true);
  }

  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: ThousandCounterApp(isFirstLaunch: isFirstLaunch),
    ),
  );
}

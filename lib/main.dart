import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';
import 'package:thousand_counter/providers/core_providers.dart';
import 'package:thousand_counter/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    observers: [
      TalkerRiverpodObserver(
        talker: TalkerFlutter.init(),
        settings: const TalkerRiverpodLoggerSettings(printStateFullData: false),
      ),
    ],
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const ThousandCounterApp(),
    ),
  );
}

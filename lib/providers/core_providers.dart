import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:thousand_counter/data/local/shared_preferences.dart';

final talkerProvider = Provider<Talker>((ref) {
  return TalkerFlutter.init(
    settings: TalkerSettings(
      useConsoleLogs: true,
      useHistory: true,
      maxHistoryItems: 500,
    ),
    logger: TalkerLogger(settings: TalkerLoggerSettings(enableColors: true)),
  );
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
final prefsManagerProvider = Provider<SharedPreferencesManager>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SharedPreferencesManager(prefs);
});

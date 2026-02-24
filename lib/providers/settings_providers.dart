import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/data/local/shared_preferences.dart';
import 'package:thousand_counter/providers/core_providers.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  final manager = ref.watch(prefsManagerProvider);
  final savedTheme = manager.getString('app_theme');
  if (savedTheme == 'dark') return ThemeMode.dark;
  if (savedTheme == 'light') return ThemeMode.light;
  if (savedTheme == 'system') return ThemeMode.system;

  return ThemeMode.system;
});
final localeProvider = StateProvider<Locale>((ref) {
  final manager = ref.watch(prefsManagerProvider);
  final savedLanguage = manager.getString('language_code');

  if (savedLanguage == 'ru') return const Locale('ru');
  if (savedLanguage == 'en') return const Locale('en');

  return const Locale('en');
});
final onboardingShownProvider =
    StateNotifierProvider<OnboardingShownNotifier, bool>((ref) {
      final manager = ref.watch(prefsManagerProvider);
      return OnboardingShownNotifier(manager);
    });

class OnboardingShownNotifier extends StateNotifier<bool> {
  final SharedPreferencesManager _manager;
  static const _key = 'onboarding_shown';

  OnboardingShownNotifier(this._manager)
      : super(_manager.getBool(_key) ?? false);

  Future<void> setShown(bool value) async {
    await _manager.setBool(_key, value);
    state = value;
  }
}

final availableThemesProvider = Provider<List<ThemeMode>>((ref) {
  return [ThemeMode.system, ThemeMode.light, ThemeMode.dark];
});

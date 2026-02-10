import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);
final localeProvider = StateProvider<Locale>((ref) {
  // final saved = SharedPreferences.getInstance()...
  // TODO: db
  // return saved ?? const Locale('en');
  return const Locale('en');
});
final availableThemesProvider = Provider<List<ThemeMode>>((ref) {
  return [ThemeMode.system, ThemeMode.light, ThemeMode.dark];
});

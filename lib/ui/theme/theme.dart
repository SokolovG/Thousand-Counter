import 'package:flutter/material.dart';
import 'package:thousand_counter/ui/theme/colors.dart';
import 'extension.dart';

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppPalette.warmBeige,
    primaryColor: AppPalette.terracotta,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPalette.terracotta,
      surface: AppPalette.warmBeige,
      onSurface: AppPalette.warmBrown,
      primary: AppPalette.terracotta,
      secondary: AppPalette.mutedBlue,
      primaryContainer: const Color(0xFFF7EBD4), // Warm pastel for highlight
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.warmBeige,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppPalette.warmBrown,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    extensions: [
      AppColors(
        barrelColor: AppPalette.terracotta,
        barrelText: AppPalette.warmBrown,
        goldCrown: AppPalette.softGold,
        cardBackground: AppPalette.cream,
        alert: const Color(0xFFD69A9A),
        shadow: AppPalette.softShadow,
        iconActive: AppPalette.mutedBlue,
        iconDelete: const Color(0xFFD69A9A),
        textPrimary: AppPalette.warmBrown,
        textSecondary: AppPalette.mutedBrown,
        iconSecondary: AppPalette.mutedBrown,
        playerHighlight: const Color(0xFFE8D7B8),
        success: const Color(0xFFB4C8B9),
        info: Colors.blue,
        warning: Colors.orange,
        bolt: AppPalette.amber,
        barrel: Colors.brown,
      ),
    ],
  );

  static final dark = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppPalette.darkWood,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPalette.amber,
      brightness: Brightness.dark,
      surface: AppPalette.darkWood,
      onSurface: AppPalette.warmText,
      primary: AppPalette.amber,
      secondary: AppPalette.mutedBlue,
      primaryContainer: AppPalette.darkCard,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.darkWood,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppPalette.warmText,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    extensions: [
      AppColors(
        barrelColor: AppPalette.amber,
        barrelText: AppPalette.warmText,
        goldCrown: AppPalette.softGold,
        cardBackground: AppPalette.darkCard,
        alert: const Color(0xFF8D5B5B),
        shadow: AppPalette.softShadow,
        iconActive: AppPalette.mutedBlue,
        iconDelete: const Color(0xFF8D5B5B),
        textPrimary: AppPalette.warmText,
        textSecondary: AppPalette.mutedBrown,
        iconSecondary: AppPalette.mutedBrown,
        playerHighlight: const Color(0xFF4A3B2F), // Lighter brown for dark theme contrast
        success: const Color(0xFF6A8773),
        info: Colors.blueAccent,
        warning: Colors.orangeAccent,
        bolt: AppPalette.softGold,
        barrel: Colors.brown,
      ),
    ],
  );
}

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
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: AppPalette.warmBrown,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: AppPalette.warmBrown,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: AppPalette.warmBrown,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppPalette.mutedBrown,
        fontSize: 14,
      ),
      labelSmall: TextStyle(
        color: AppPalette.mutedBrown,
        fontSize: 12,
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
        gridBorder: const Color(0xFF7A9682), // Darker muted sage for light
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
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: AppPalette.warmText,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: AppPalette.warmText,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: AppPalette.warmText,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppPalette.mutedBrown,
        fontSize: 14,
      ),
      labelSmall: TextStyle(
        color: AppPalette.mutedBrown,
        fontSize: 12,
      ),
    ),
    extensions: [
      AppColors(
        barrelColor: AppPalette.amber,
        barrelText: AppPalette.warmText,
        goldCrown: AppPalette.softGold,
        cardBackground: AppPalette.darkCard,
        alert: const Color(0xFFAB6B6B), // Brightened muted red
        shadow: AppPalette.softShadow,
        iconActive: AppPalette.mutedBlue,
        iconDelete: const Color(0xFFAB6B6B),
        textPrimary: AppPalette.warmText,
        textSecondary: AppPalette.mutedBrown,
        iconSecondary: AppPalette.mutedBrown,
        playerHighlight: const Color(0xFF4A3B2F), // Lighter brown for dark theme contrast
        gridBorder: const Color(0xFF4D6153), // Deep dark sage for dark
        success: const Color(0xFF829E8A), // Brightened muted green
        info: Colors.blueAccent,
        warning: Colors.orangeAccent,
        bolt: AppPalette.softGold,
        barrel: Colors.brown,
      ),
    ],
  );
}

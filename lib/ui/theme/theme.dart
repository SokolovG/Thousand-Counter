import 'package:flutter/material.dart';
import 'package:thousand_counter/ui/theme/colors.dart';
import 'extension.dart';

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromARGB(255, 235, 235, 164),
    primaryColor: AppPalette.red,
    extensions: [
      AppColors(
        barrelColor: AppPalette.red,
        barrelText: AppPalette.black,
        goldCrown: AppPalette.gold,
        cardBackground: AppPalette.white,
        alert: AppPalette.red,
        shadow: AppPalette.black5,
        iconActive: AppPalette.blue,
        iconDelete: AppPalette.red,
        textPrimary: AppPalette.black,
        textSecondary: AppPalette.darkGrey,
        iconSecondary: AppPalette.lightGrey,
      ),
    ],
  );

  static final dark = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppPalette.darkGrey,
    colorScheme: const ColorScheme.dark(),

    extensions: [
      AppColors(
        barrelColor: AppPalette.orange,
        barrelText: AppPalette.white,
        goldCrown: AppPalette.gold,
        cardBackground: AppPalette.darkGrey,
        alert: AppPalette.red,
        shadow: AppPalette.black5,
        iconActive: AppPalette.blue,
        iconDelete: AppPalette.red,
        textPrimary: AppPalette.white,
        textSecondary: AppPalette.lightGrey,
        iconSecondary: AppPalette.lightGrey,
      ),
    ],
  );
}

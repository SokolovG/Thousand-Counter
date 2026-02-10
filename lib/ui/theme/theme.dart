import 'package:flutter/material.dart';
import 'colors.dart';
import 'extension.dart';

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromARGB(255, 235, 235, 164),
    primarySwatch: Colors.pink,
    extensions: [
      AppColors(
        barrelColor: AppPalette.red,
        barrelText: AppPalette.black,
        goldCrown: AppPalette.gold,
        cardBackground: AppPalette.white,
        alert: AppPalette.red,
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
        goldCrown: Colors.yellowAccent,
        cardBackground: Colors.black45,
        alert: Colors.redAccent,
      ),
    ],
  );
}

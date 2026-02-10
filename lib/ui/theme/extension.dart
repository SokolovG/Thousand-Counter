import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color? barrelColor;
  final Color? barrelText;
  final Color? goldCrown;
  final Color? cardBackground;
  final Color? alert;

  const AppColors({
    required this.barrelColor,
    required this.barrelText,
    required this.goldCrown,
    required this.cardBackground,
    required this.alert,
  });

  @override
  AppColors copyWith({
    Color? barrelColor,
    Color? barrelText,
    Color? goldCrown,
    Color? cardBackground,
    Color? alert,
  }) {
    return AppColors(
      barrelColor: barrelColor ?? this.barrelColor,
      barrelText: barrelText ?? this.barrelText,
      goldCrown: goldCrown ?? this.goldCrown,
      cardBackground: cardBackground ?? this.cardBackground,
      alert: alert ?? this.alert,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      barrelColor: Color.lerp(barrelColor, other.barrelColor, t),
      barrelText: Color.lerp(barrelText, other.barrelText, t),
      goldCrown: Color.lerp(goldCrown, other.goldCrown, t),
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t),
      alert: Color.lerp(alert, other.alert, t),
    );
  }
}

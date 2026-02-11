import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color barrelColor;
  final Color barrelText;
  final Color goldCrown;
  final Color cardBackground;
  final Color alert;
  final Color shadow;
  final Color iconActive;
  final Color iconDelete;
  final Color textPrimary;
  final Color textSecondary;
  final Color iconSecondary;

  const AppColors({
    required this.barrelColor,
    required this.barrelText,
    required this.goldCrown,
    required this.cardBackground,
    required this.alert,
    required this.shadow,
    required this.iconActive,
    required this.iconDelete,
    required this.textPrimary,
    required this.textSecondary,
    required this.iconSecondary,
  });

  @override
  AppColors copyWith({
    Color? barrelColor,
    Color? barrelText,
    Color? goldCrown,
    Color? cardBackground,
    Color? alert,
    Color? shadow,
    Color? iconActive,
    Color? iconDelete,
    Color? textPrimary,
    Color? textSecondary,
    Color? iconSecondary,
  }) {
    return AppColors(
      barrelColor: barrelColor ?? this.barrelColor,
      barrelText: barrelText ?? this.barrelText,
      goldCrown: goldCrown ?? this.goldCrown,
      cardBackground: cardBackground ?? this.cardBackground,
      alert: alert ?? this.alert,
      shadow: shadow ?? this.shadow,
      iconActive: iconActive ?? this.iconActive,
      iconDelete: iconDelete ?? this.iconDelete,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      iconSecondary: iconSecondary ?? this.iconSecondary,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      barrelColor: Color.lerp(barrelColor, other.barrelColor, t)!,
      barrelText: Color.lerp(barrelText, other.barrelText, t)!,
      goldCrown: Color.lerp(goldCrown, other.goldCrown, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      alert: Color.lerp(alert, other.alert, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      iconActive: Color.lerp(iconActive, other.iconActive, t)!,
      iconDelete: Color.lerp(iconDelete, other.iconDelete, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t)!,
    );
  }
}

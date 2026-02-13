import 'package:flutter/material.dart';
import 'extension.dart';

class TextStyles {
  TextStyles._();

  static TextStyle onPrimaryTitleText(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!;
  }

  static TextStyle onPrimarySubTitleText(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!;
  }

  static TextStyle titleStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!;
  }

  static TextStyle playerName(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!;
  }

  static TextStyle scoreText(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle errorSmall(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Theme.of(context).textTheme.labelSmall!.copyWith(
          color: appColors.alert,
          fontWeight: FontWeight.bold,
        );
  }
}

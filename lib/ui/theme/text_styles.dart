import 'package:flutter/material.dart';
import 'extension.dart';

class TextStyles {
  TextStyles._();

  static TextStyle onPrimaryTitleText(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return TextStyle(
      color: appColors.textPrimary,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle onPrimarySubTitleText(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return TextStyle(color: appColors.textPrimary);
  }

  static TextStyle titleStyle(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return TextStyle(
      color: appColors.textPrimary,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }
}

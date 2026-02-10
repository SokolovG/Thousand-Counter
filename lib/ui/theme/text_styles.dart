import 'package:flutter/material.dart';

class TextStyles {
  TextStyles._();

  static TextStyle get onPrimaryTitleText {
    return const TextStyle(color: Colors.white, fontWeight: FontWeight.w600);
  }

  static TextStyle get onPrimarySubTitleText {
    return const TextStyle(color: Colors.white);
  }

  static TextStyle get titleStyle {
    return const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }
}

import 'package:flutter/material.dart';

class OnboardingSlide {
  final String imagePath;

  final String hintText;

  final Alignment hintAlignment;

  final String title;

  final String description;

  const OnboardingSlide({
    required this.imagePath,
    required this.hintText,
    required this.hintAlignment,
    required this.title,
    required this.description,
  });
}

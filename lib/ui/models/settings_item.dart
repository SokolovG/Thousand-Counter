import 'package:flutter/material.dart';

enum SettingsItemType { navigation, toggle, info }

class SettingsItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final SettingsItemType type;
  final VoidCallback? onTap;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  const SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.type,
    this.onTap,
    this.switchValue,
    this.onSwitchChanged,
  });
}

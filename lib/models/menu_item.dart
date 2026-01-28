import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData? icon;
  final String route;

  const MenuItem({required this.title, this.icon, required this.route});
}

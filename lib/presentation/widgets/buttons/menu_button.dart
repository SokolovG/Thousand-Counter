import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MenuButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: theme.textTheme.bodyMedium,
        minimumSize: const Size(200, 50),
      ),
      onPressed: onPressed,
      child: Text(text, style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}

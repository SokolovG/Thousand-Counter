import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {
  final String name;

  const PlayerWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 14,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: theme.textTheme.titleLarge),
            IconButton(onPressed: () {}, icon: Icon(Icons.edit_note)),
          ],
        ),
      ),
    );
  }
}
